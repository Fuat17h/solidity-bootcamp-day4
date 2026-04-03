# Bank Smart Contract & Foundry Testing - Day 4

A simple Bank contract demonstrating ETH deposits and withdrawals, accompanied by a robust testing suite built with Foundry.

## Features

- **Deposit:** Users can securely send ETH to the contract.
- **Withdraw:** Users can withdraw up to their total deposited balance (utilizing the Checks-Effects-Interactions pattern for security).
- **Balance Check:** View the ledger balance of any specific address.

## Running Tests with Foundry

This project uses Foundry (`forge`). Make sure Foundry is installed on your machine.

1. **Install dependencies (if cloning):**
   ```bash
   forge install
   ```
