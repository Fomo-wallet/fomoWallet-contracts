// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract BettingGame is ERC721, Ownable {
    struct Bet {
        uint256 amount; // Maximum betting amount
        string hostTwitter; // Host's Twitter handle
        string encryptedKey; // Encrypted key
        address host; // Address of the host
        bool active; // Whether the bet is active
        uint256 endTime; // The bet will be closed on this time
        address supportedBettingToken; // Token used for betting
    }

    struct UsersHistoricalBets {
        uint256 amount;
        address userAddress;
        string emailAddress;
        string twitter;
    }

    address public agentAddress;

    uint256 public betCounter = 0;
    mapping(uint256 => Bet) public bets;
    mapping(uint256 => string) public betsToUrl;
    mapping(uint256 => UsersHistoricalBets[]) public userBets;

    event BetCreated(
        uint256 betId,
        uint256 amount,
        string hostTwitter,
        address host,
        uint256 endTimeStamp,
        string privateKey,
        string hostEmail
    );
    event BetActivated(uint256 betId, string tokenURI);
    event BetPlaced(
        uint256 betId,
        address bettor,
        string bettorTwitter,
        string bettorEmail,
        uint256 amount
    );
    event BetClosed(
        uint256 betId,
        address winner,
        string winnerTwitter,
        string winnerEmail,
        uint256 actualAmount
    );
    event BetCancelled(uint256 betId, address host);

    modifier onlyAgent() {
        require(
            msg.sender == agentAddress,
            "Only the agent can call this function"
        );
        _;
    }

    constructor(address _agentAddress)
        ERC721("BetNFT", "BFT")
        Ownable(msg.sender)
    {
        agentAddress = _agentAddress;
    }

    // Host a new bet
    function hostBet(
        uint256 amount,
        uint256 timeToEnd,
        string memory hostTwitter,
        string memory encryptedKey,
        string memory hostEmail,
        address supportedBettingToken
    ) public {
        require(amount > 0, "Bet amount must be greater than zero");
        require(timeToEnd > block.timestamp, "End time must be in the future");

        // Transfer funds from the host to the contract
        IERC20(supportedBettingToken).transferFrom(msg.sender, address(this), amount);

        bets[betCounter] = Bet({
            amount: amount,
            hostTwitter: hostTwitter,
            encryptedKey: encryptedKey,
            host: msg.sender,
            active: false,
            endTime: timeToEnd,
            supportedBettingToken: supportedBettingToken
        });

        emit BetCreated(
            betCounter,
            amount,
            hostTwitter,
            msg.sender,
            timeToEnd,
            encryptedKey,
            hostEmail
        );
        betCounter++;
    }

    // Secure a bet: Mint NFT with URI from the AI agent and activate the bet
    function secureBet(uint256 betId, string memory tokenURI)
        external
        onlyAgent
    {
        Bet storage bet = bets[betId];
        require(!bet.active, "Bet is already active");

        bet.active = true;
        betsToUrl[betId] = tokenURI;

        emit BetActivated(betId, tokenURI);
    }

    // Place a bet
    function placeBet(
        uint256 betId,
        uint256 amount,
        string memory bettorTwitter,
        string memory bettorEmail
    ) public {
        Bet storage bet = bets[betId];
        require(bet.active, "Bet is not active");
        require(block.timestamp < bet.endTime, "Betting time has expired");
        require(amount > 0, "Bet amount must be greater than zero");

        // Transfer funds from the bettor to the contract
        IERC20(bet.supportedBettingToken).transferFrom(msg.sender, address(this), amount);

        userBets[betId].push(
            UsersHistoricalBets({
                amount: amount,
                userAddress: msg.sender,
                emailAddress: bettorEmail,
                twitter: bettorTwitter
            })
        );

        emit BetPlaced(
            betId,
            msg.sender,
            bettorTwitter,
            bettorEmail,
            amount
        );
    }

    // Cancel a bet
    function cancelBet(uint256 betId) external onlyOwner{
        Bet storage bet = bets[betId];
        require(bet.host == msg.sender, "Only the host can cancel the bet");
        require(!bet.active, "Cannot cancel an active bet");

        // Refund the host
        IERC20(bet.supportedBettingToken).transfer(bet.host, bet.amount);

        delete bets[betId];
        emit BetCancelled(betId, msg.sender);
    }

    // Close the bet when the agent provides the actual amount
    function closeBetWhenTimeEnds(uint256 betId, uint256 actualAmount)
        public
        onlyAgent
    {
        Bet storage bet = bets[betId];
        require(bet.active, "Bet is not active");
        require(block.timestamp >= bet.endTime, "Betting period is not over");

        // Determine the winner with the closest bet
        address winner;
        string memory winnerTwitter;
        string memory winnerEmail;
        uint256 closestDifference = type(uint256).max;

        for (uint256 i = 0; i < userBets[betId].length; i++) {
            UsersHistoricalBets memory userBet = userBets[betId][i];
            uint256 difference = actualAmount > userBet.amount
                ? actualAmount - userBet.amount
                : userBet.amount - actualAmount;

            if (difference < closestDifference) {
                closestDifference = difference;
                winner = userBet.userAddress;
                winnerTwitter = userBet.twitter;
                winnerEmail = userBet.emailAddress;
            }
        }

        require(winner != address(0), "No valid bets placed");

        bet.active = false;

        // Transfer funds to the winner
        IERC20(bet.supportedBettingToken).transfer(winner, bet.amount);

        _mint(winner,betId);

        // Emit BetClosed event
        emit BetClosed(betId, winner, winnerTwitter, winnerEmail, actualAmount);
    }
}
