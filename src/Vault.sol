// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Vault {
    mapping(address => uint256) public balances;
    uint256 public totalAssets;

    // Eventos para trackeo
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // Permite a los usuarios depositar Ether
    function deposit() public payable {
        require(msg.value > 0, "No se puede depositar 0");
        balances[msg.sender] += msg.value;
        totalAssets += msg.value;
        emit Deposit(msg.sender, msg.value);
    }

    // Permite retirar una cantidad específica
    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Saldo insuficiente");
        
        // Efectuar el retiro
        balances[msg.sender] -= _amount;
        totalAssets -= _amount;
        
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transferencia fallida");
        
        emit Withdraw(msg.sender, _amount);
    }

    // Función de utilidad para ver el balance de la bóveda
    function getExternalBalance() public view returns (uint256) {
        return address(this).balance;
    }
}