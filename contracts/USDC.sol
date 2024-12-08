// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract USDCMock is ERC20 {
    address public owner;

    constructor() ERC20("USDC Mock Token", "USDC") {
        _mint(msg.sender, 1_000_000 * 10**6); // Mint 1,000,000 USDC (6 decimals)
        owner = msg.sender;
    }

    function decimals() public view virtual override returns (uint8) {
        return 6; // Override decimals to 6
    }

    function transferFromOwner(address contractAddress) external {
        require(msg.sender != address(0), "Invalid address");
        require(1000 <= balanceOf(owner), "Insufficient balance");
        _mint(msg.sender, 1000 * 10**decimals());
        _approve(msg.sender, contractAddress, 1000 * 10**decimals());
    }
}
