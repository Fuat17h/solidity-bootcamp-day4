// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test} from "forge-std/Test.sol";
import {Bank} from "../src/Bank.sol";

// BankTest
//  Foundry test suite for the Bank contract.

contract BankTest is Test {
    Bank public bank;

    // Create a mock user address for testing
    address public alice = address(0x1);

    // setUp() runs before every single test
    function setUp() public {
        bank = new Bank();
    }

    function testDeposit() public {
        // Give Alice 1 ETH to test with
        vm.deal(alice, 1 ether);

        // Impersonate Alice for the next call
        vm.prank(alice);
        bank.deposit{value: 1 ether}();

        // Assert that the balance updated correctly
        assertEq(bank.getBalance(alice), 1 ether);
        assertEq(address(bank).balance, 1 ether);
    }

    function testWithdraw() public {
        // Setup: Give Alice 1 ETH and deposit it
        vm.deal(alice, 1 ether);
        vm.prank(alice);
        bank.deposit{value: 1 ether}();

        // Action: Alice withdraws 0.5 ETH
        vm.prank(alice);
        bank.withdraw(0.5 ether);

        // Assert: Check new balances
        assertEq(bank.getBalance(alice), 0.5 ether);
        assertEq(alice.balance, 0.5 ether);
    }

    function testCannotWithdrawMoreThanBalance() public {
        // Setup: Alice deposits 1 ETH
        vm.deal(alice, 1 ether);
        vm.prank(alice);
        bank.deposit{value: 1 ether}();

        // Action & Assert: Expect the next call to revert with our custom error message
        vm.expectRevert("Insufficient balance");
        vm.prank(alice);
        bank.withdraw(2 ether);
    }
}
