# 🏦 Foundry Fuzz Vault

[![Solidity](https://img.shields.io/badge/Solidity-0.8.13-363636.svg?style=flat-square&logo=solidity&logoColor=white)](https://docs.soliditylang.org/)
[![Foundry](https://img.shields.io/badge/Framework-Foundry-FFDE00.svg?style=flat-square)](https://book.getfoundry.sh/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=flat-square)](https://opensource.org/licenses/MIT)

A security-focused smart contract project demonstrating **Stateless Fuzz Testing** using the Foundry framework. This repository features a decentralized Vault for Ether deposits and withdrawals, focusing on rigorous property-based testing to ensure financial integrity.

## 🎯 Project Overview

The core of this project is a `Vault.sol` contract designed to manage user funds. The primary goal is to showcase **modern testing methodologies** that go beyond simple unit tests to ensure contract robustness against unexpected inputs and edge cases.

### Key Features
* **Ether Custody:** Simple and secure handling of native ETH deposits and withdrawals.
* **Internal Accounting:** Manual tracking of `totalAssets` and individual user `balances` to maintain system state.
* **Stateless Fuzzing:** Leveraging Foundry's fuzzer to validate that contract requirements (like sufficient balance) hold true across thousands of randomized scenarios.

## 🧪 Testing Methodology

### Stateless Fuzzing (Current Focus)
Instead of testing with fixed values, I utilize **Foundry's Fuzzer** to stress-test the contract logic with randomized inputs.

* **Boundary Analysis:** Testing `deposit()` and `withdraw()` with a vast range of `uint256` values (from 1 wei to extreme amounts).
* **Error Handling:** Ensuring that `require` statements (e.g., "insufficient balance") correctly revert under randomized conditions.
* **Logic Validation:** Verifying that the internal `balances` mapping always updates correctly relative to the `msg.value` provided.

## 📂 Project Structure

```text
├── src/
│   └── Vault.sol          # Smart contract logic (Deposit/Withdraw)
├── test/
│   └── Vault.t.sol
├── lib/                   # External dependencies (Forge-std)
└── foundry.toml           # Fuzzer configuration (runs, seeds, etc.)


## 🗺️ Roadmap & Future Work
[ ] Stateful Fuzzing (Invariant Testing): Implementing system-wide properties that must hold true across a sequence of multiple transactions.

[ ] ERC-4626 Integration: Transitioning to the tokenized vault standard.

[ ] Formal Verification: Using Halmos or Kontrol to mathematically prove contract properties.