// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MessageBoard {
    string private message;
    address public lastSender;
    uint256 public lastUpdatedAt;

    event MessageUpdated(address indexed sender, string newMessage, uint256 timestamp);

    function setMessage(string memory newMessage) public {
        message = newMessage;
        lastSender = msg.sender;
        lastUpdatedAt = block.timestamp;

        emit MessageUpdated(msg.sender, newMessage, block.timestamp);
    }

    function getMessage() public view returns (string memory) {
        return message;
    }
}
