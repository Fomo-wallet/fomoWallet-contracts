// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/access/Ownable.sol";
import "fhevm/lib/TFHE.sol";
import "fhevm/gateway/GatewayCaller.sol";

contract IncoKeyContract is GatewayCaller, Ownable {
    address public agentAddress;

    constructor(address _agentAddress) Ownable(msg.sender) {
        agentAddress = _agentAddress;
    }

    modifier onlyTrustedAgent() {
        require(msg.sender == agentAddress);
        _;
    }

    mapping(bytes32 uniqueKey => euint64 _encryptedKey) public keyToConfidentialKey;
    mapping(bytes32 uniqueKey => euint64 _encryptedAmount) public keyToConfidentialAmount;

    function storeConfidentialNFT(
        uint256 _betId,
        uint32 _chainId,
        address _originContractAddress,
        einput _encryptedKey,
        einput _encryptedAmount,
        bytes calldata inputProof
    ) external onlyTrustedAgent {
        bytes32 uniqueKey = keccak256(abi.encodePacked(_betId, _chainId, _originContractAddress));
        keyToConfidentialKey[uniqueKey] = TFHE.asEuint64(_encryptedKey, inputProof);
        keyToConfidentialAmount[uniqueKey] = TFHE.asEuint64(_encryptedAmount, inputProof);
        TFHE.allow(keyToConfidentialKey[uniqueKey], address(this));
        TFHE.allow(keyToConfidentialKey[uniqueKey], agentAddress);

        TFHE.allow(keyToConfidentialAmount[uniqueKey], address(this));
        TFHE.allow(keyToConfidentialAmount[uniqueKey], agentAddress);
    }

    function getDeterminsticKey(
        uint256 _betId,
        uint32 _chainId,
        address _originContractAddress
    ) external pure returns (bytes32) {
        return keccak256(abi.encodePacked(_betId, _chainId, _originContractAddress));
    }

    function readConfientialKeyFromRawParams(
        uint256 _betId,
        uint32 _chainId,
        address _originContractAddress
    ) external view returns (euint64) {
        bytes32 key = keccak256(abi.encodePacked(_betId, _chainId, _originContractAddress));
        return keyToConfidentialKey[key];
    }

    function readConfientialAmountFromRawParams(
        uint256 _betId,
        uint32 _chainId,
        address _originContractAddress
    ) external view returns (euint64) {
        bytes32 key = keccak256(abi.encodePacked(_betId, _chainId, _originContractAddress));
        return keyToConfidentialAmount[key];
    }

    function readConfientialKeyFromKey(bytes32 key) external view returns (euint64) {
        return keyToConfidentialKey[key];
    }
    
}
