// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Bank
// A simple contract for depositing, withdrawing, and checking ETH balances.

contract Bank {
    // State variable to track user balances
    mapping(address => uint256) private balances;

    // Allows users to deposit ETH into the contract.
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balances[msg.sender] += msg.value;
    }

    // Allows users to withdraw their deposited ETH.
    // amount The amount of ETH to withdraw in wei.

    function withdraw(uint256 amount) public {
        require(amount > 0, "Withdrawal amount must be greater than zero");
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // Follows the Checks-Effects-Interactions pattern to prevent reentrancy
        balances[msg.sender] -= amount;

        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "ETH transfer failed");
    }

    // Returns the balance of a specific user.
    // user The address of the user.
    // The balance of the user in wei.

    function getBalance(address user) public view returns (uint256) {
        return balances[user];
    }
}
