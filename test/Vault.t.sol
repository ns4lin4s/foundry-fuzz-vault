// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test} from "../lib/forge-std/src/Test.sol";
import {Vault} from "../src/Vault.sol";

contract VaultTest is Test {
    Vault public vault;

    function setUp() public {
        vault = new Vault();
    }

    function testFuzz_Deposit(uint256 amount) public {
        vm.assume(amount > 0 && amount <= address(this).balance);

        uint256 preBalance = vault.totalAssets();

        vault.deposit{value: amount}();

        assertEq(vault.balances(address(this)), amount);
        assertEq(vault.totalAssets(), preBalance + amount);
    }

    function testCheckBalance() public {
        uint256 val = 100;
        vault.deposit{ value: val }();
        assert(val == vault.getExternalBalance());
    }

    function testWithdraw() public {
        uint256 val = 100;
        vault.deposit{ value: val }();
        vault.withdraw(100);
        assert(vault.getExternalBalance() == 0);
    }

    function testCanNotWithdraw() public {
        uint256 val = 2000;
        vm.expectRevert();
        vault.withdraw(val);
    }

    function testDepositZero() public {
        
        uint256 deposit = 0;
        vm.expectRevert();
        vault.deposit{ value: deposit }();
    }

    function testGetBalance() public view {
        assert(vault.getExternalBalance() == 0);
    }

    function test_RevertIf_WithdrawMoreThanBalance() public {
        uint256 amount = 1 ether;
        vm.deal(address(this), amount);
        
        vault.deposit{value: amount}();
        
        vm.expectRevert();
        vault.withdraw(amount + 1); // we try withdraw 1 ETH + 1 wei.
    }

    receive() external payable {}
}
