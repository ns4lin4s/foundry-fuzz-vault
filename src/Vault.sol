// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Vault {
    mapping(address => uint256) public balances;
    uint256 public totalAssets;

    // Events
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Allow to user deposit ethers
    function deposit() public payable {
        require(msg.value > 0, "You can not deposit 0");
        balances[msg.sender] += msg.value;
        totalAssets += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Allow withdraw a specific balance
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "insufficient balance");
        
        balances[msg.sender] -= _amount;
        totalAssets -= _amount;
        
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "transfer failed");
        
        emit Withdraw(msg.sender, _amount);
    }

    // Check account balance.
    function getExternalBalance() public view returns (uint256) {
        return address(this).balance;
    }
}