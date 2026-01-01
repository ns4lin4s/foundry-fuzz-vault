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

    receive() external payable {}
}
