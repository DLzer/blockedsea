# BlockedSea ⛔⛵

This is a *non-serious* WIP project to demonstrate the possibility of blocking OpenSea and to learn more about the Solidity ecosystem. It's in no way meant to be taken seriously, however constructive criticism and contribution is encouraged.

## About

The primary feature of this project is the `BlockedSea.sol` contract. The abstract contract gives the owner the ability to enable or disable the OpenSea blocking modifier. By default the contract is registered to block OpenSea, however this can be toggled via the `setBlockOpenSea(bool)` function. The example contracts override the `approve` and `setApprovalForAll` functions with the inclusion of the `blockOpenSea` modifier.

## Installation

1. Clone or Fork this repository.
2. Install deps:
```bash
npm i
```
3. Test:
```bash
npm test || npx hardhat test
```

## TODO
- More tests (Administrative, Coverage, etc..)
- Optimize gas savings even further

## Acknowledgements

This project is inspired by the workings of Vectorized and their project:
- [closedsea](https://github.com/Vectorized/closedsea)