# Lux Network

Post-quantum blockchain with multi-consensus architecture, fully homomorphic encryption (FHE), and cross-chain interoperability. High-performance decentralized infrastructure for the next generation of secure, scalable applications.

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Lux features a novel Snow consensus family (Snowball, Snowflake, Avalanche, Frosty), multi-chain architecture (X-Chain DAG, P-Chain platform, C-Chain EVM, custom subnets), and an integrated post-quantum cryptography stack including lattice-based signatures, FHE, and threshold MPC.

## Quick Start

```bash
# Install Lux CLI
go install github.com/luxfi/cli@latest

# Create a local network
lux network start

# Deploy a subnet
lux subnet create mysubnet
lux subnet deploy mysubnet
```

## Architecture

```
Chains:     X-Chain (DAG)  |  P-Chain (Platform)  |  C-Chain (EVM)  |  Subnets
                           |
Consensus:  Snow Family — Snowball, Snowflake, Avalanche, Frosty
                           |
Crypto:     Lattice signatures  |  FHE  |  Threshold MPC  |  Zero-knowledge
                           |
Bridge:     Teleport — Zero-knowledge MPC cross-chain bridge
```

## Core Projects

### Blockchain Infrastructure
| Project | Description |
|---------|-------------|
| [node](https://github.com/luxfi/node) | Lux blockchain node — multi-consensus, post-quantum ready |
| [standard](https://github.com/luxfi/standard) | Reference implementation of Teleport protocol and quantum signatures |
| [teleport](https://github.com/luxfi/teleport) | Zero-knowledge MPC cross-chain bridge |
| [coreth](https://github.com/luxfi/coreth) | C-Chain EVM implementation |
| [subnet-evm](https://github.com/luxfi/subnet-evm) | Subnet EVM framework |

### Applications
| Project | Description |
|---------|-------------|
| [market](https://github.com/luxfi/market) | Web3 marketplace for real-world assets (RWAs) |
| [bank](https://github.com/luxfi/bank) | Open source banking-as-a-service platform |
| [explorer](https://github.com/luxfi/explorer) | Block explorer |
| [wallet](https://github.com/luxfi/wallet) | HD wallet implementation |

### SDKs and Tools
| Project | Description |
|---------|-------------|
| [js-sdk](https://github.com/luxfi/js-sdk) | Lux JavaScript SDK |
| [sdk](https://github.com/luxfi/sdk) | Multi-language SDK (Go, TypeScript, Python) |
| [cli](https://github.com/luxfi/cli) | Command-line interface |
| [netrunner](https://github.com/luxfi/netrunner) | Network testing and simulation tool |

## Related Organizations

| Organization | Focus |
|--------------|-------|
| [Hanzo AI](https://github.com/hanzoai) | AI infrastructure — LLM gateway, MCP, agents |
| [Zen LM](https://github.com/zenlm) | Frontier language models (600M-480B params) |
| [Zoo Labs](https://github.com/zoo-labs) | Open AI research network (501c3) |

## Resources

- [lux.network](https://lux.network) — Website
- [docs.lux.network](https://docs.lux.network) — Documentation
- [explorer.lux.network](https://explorer.lux.network) — Block explorer

Apache 2.0 -- See individual repositories for details.

*Built by the Lux team in collaboration with [Hanzo AI](https://hanzo.ai)*
