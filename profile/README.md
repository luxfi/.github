# Lux Network

Post-quantum blockchain with multi-consensus architecture, fully homomorphic encryption (FHE), and cross-chain interoperability. High-performance decentralized infrastructure for the next generation of secure, scalable applications.

Lux features the Quasar consensus family, multi-chain architecture (X-Chain DAG, P-Chain platform, C-Chain EVM, custom subnets), and an integrated post-quantum cryptography stack including lattice-based signatures, FHE, and threshold MPC.

## Quick Start

```bash
# Install Lux CLI
go install github.com/luxfi/cli@latest

# Create a local network
lux network start

# Deploy a chain
lux chain create L1
lux chain deploy L1
```

## Architecture

```
Chains:     X-Chain (DAG)  |  P-Chain (Platform)  |  C-Chain (EVM)  |  Subnets
                           |
Consensus:  Quasar Family -- Snowball, Snowflake, Avalanche, Frosty, P3Q
                           |
Crypto:     Lattice signatures  |  FHE  |  Threshold MPC  |  Zero-knowledge
                           |
Bridge:     Teleport -- Zero-knowledge MPC cross-chain bridge
```

## IP and Licensing Strategy

Lux ships a three-tier IP strategy. Read this before forking, embedding, or
building a commercial product on top of Lux code.

| Tier | Where it lives | License | Free for | Commercial use |
|------|----------------|---------|----------|----------------|
| **Public** | `github.com/luxfi/*` (BSD-3 repos) | BSD-3-Clause | Anyone, any purpose, including commercial | Permitted, no fee |
| **Patent-protected** | `github.com/luxfi/*` (Eco repos) | Lux Ecosystem License v1.2 | Authorized Networks (Lux Primary NetID=1, EVM 96369; official testnets/devnets; Descending Chains) and Research Use | Requires a paid commercial license outside Authorized Networks |
| **Private moat** | Not on public GitHub | Commercial license / NDA | Lux + contracted customers | Contact `licensing@lux.network` |

Definitions ("Authorized Network", "Descending Chain", "Research Use",
"Commercial Use") are the ones in the Lux Ecosystem License v1.2 — see any
Eco-tier repo's `LICENSE` for the binding text.

The **public BSD-3 path is the open reference**: pure-Go, portable, slower,
complete enough to run a node end-to-end. The **patent-protected tier**
publishes the inventions (so prior art is established) but gates commercial
exploitation outside Authorized Networks. The **private moat** is the
production-grade C++/CUDA/MLX/FPGA implementation of the same algorithms —
the actual performance you cannot get otherwise.

### What you can do without paying us

| You are | Doing this | Outcome |
|---------|------------|---------|
| Researcher / academic | Anything, any tier | Free under "Research Use" |
| Hobbyist / personal | Anything, any tier | Free; Eco free for personal/non-commercial |
| Commercial product | Building on a Descending Chain | Free; you are an Authorized Network |
| Commercial product | Forking BSD-3 code into a sovereign L1 | Free; BSD-3 is unrestricted |
| Commercial product | Embedding Eco-tier code in a sovereign L1 | Commercial license required |
| Commercial product | Using the private moat | Contract via `licensing@lux.network` |

### Repository classification

| Repository | License | Tier |
|------------|---------|------|
| accel | BSD-3-Clause | Public |
| address | BSD-3-Clause | Public |
| ai | Lux Ecosystem v1.2 | Patent-protected † |
| api | BSD-3-Clause | Public |
| atomic | MIT (legacy) | Public |
| benchlist | BSD-3-Clause | Public |
| bft | BSD-3-Clause | Public |
| bridge | Lux Ecosystem v1.2 | Patent-protected † |
| cache | BSD-3-Clause | Public |
| cli | BSD-3-Clause | Public |
| codec | BSD-3-Clause | Public |
| compress | BSD-3-Clause | Public |
| concurrent | BSD-3-Clause | Public |
| config | BSD-3-Clause | Public |
| consensus | Lux Ecosystem v1.2 | Patent-protected † |
| constants | BSD-3-Clause | Public |
| container | BSD-3-Clause | Public |
| corona | Lux Ecosystem v1.2 | Patent-protected † |
| crypto | Lux Ecosystem v1.2 | Patent-protected † |
| dao | Lux Research with Patent Reservation | Patent-protected |
| database | BSD-3-Clause | Public |
| dex | Lux Research with Patent Reservation | Patent-protected |
| evm | LGPL-3 (inherited from go-ethereum) | Public, copyleft |
| evmgpu | LGPL-3 (inherited from go-ethereum) | Public, copyleft |
| exchange | Lux Ecosystem v1.2 | Patent-protected |
| explore | GPL-3 (inherited from Blockscout) | Public, copyleft |
| fhe | Lux Ecosystem v1.2 | Patent-protected |
| fhe-coprocessor | Lux Ecosystem v1.2 | Patent-protected |
| filesystem | BSD-3-Clause | Public |
| fpga | Lux Ecosystem v1.2 | Patent-protected |
| genesis | BSD-3-Clause | Public |
| geth | BSD-3-Clause (Lux fork) | Public |
| ids | BSD-3-Clause | Public |
| keychain | BSD-3-Clause | Public |
| keys | BSD-3-Clause | Public |
| kit | BSD-3-Clause | Public |
| kms | Lux Ecosystem v1.2 | Patent-protected † |
| lamport | Lux Ecosystem v1.2 | Patent-protected † |
| lattice | Lux Ecosystem v1.2 | Patent-protected † |
| log | BSD-3-Clause | Public |
| markets | BSL 1.1 (inherited from Morpho Blue) | Public, time-limited |
| math | BSD-3-Clause | Public |
| metric | BSD-3-Clause | Public |
| miner | Lux Research with Patent Reservation | Patent-protected |
| mpc | Lux Ecosystem v1.2 | Patent-protected † |
| net | BSD-3-Clause | Public |
| netrunner | BSD-3-Clause | Public |
| node | BSD-3-Clause | Public |
| oracle | BSD-3-Clause | Public |
| ordering | BSD-3-Clause | Public |
| p2p | BSD-3-Clause | Public |
| precompile | Lux Ecosystem v1.2 | Patent-protected † |
| price | BSD-3-Clause | Public |
| protocol | BSD-3-Clause | Public |
| pubsub | BSD-3-Clause | Public |
| pulsar | Apache-2.0 | Public |
| pulsar-mptc | Apache-2.0 | Public |
| qzmq | Apache-2.0 | Public |
| ringtail | Lux Ecosystem v1.2 | Patent-protected † |
| rpc | BSD-3-Clause | Public |
| runtime | BSD-3-Clause | Public |
| safe | Lux Ecosystem v1.2 | Patent-protected † |
| sampler | Lux Research with Patent Reservation | Patent-protected |
| sdk | BSD-3-Clause | Public |
| session | BSD-3-Clause | Public |
| snapshots | BSD-3-Clause | Public |
| stack | BSD-3-Clause | Public |
| staking | Lux Research with Patent Reservation | Patent-protected |
| standard | BSD-3-Clause | Public |
| state | Lux Genesis License v1.0 | Patent-protected (genesis-data carve-out) |
| sys | BSD-3-Clause | Public |
| teleport | BSD-3-Clause | Public |
| threshold | Lux Ecosystem v1.2 | Patent-protected † |
| timer | BSD-3-Clause | Public |
| tls | BSD-3-Clause | Public |
| trace | BSD-3-Clause | Public |
| upgrade | BSD-3-Clause | Public |
| utils | BSD-3-Clause | Public |
| utxo | BSD-3-Clause | Public |
| validators | BSD-3-Clause | Public |
| version | BSD-3-Clause | Public |
| vm | Lux Research with Patent Reservation | Patent-protected |
| wallet | Lux Ecosystem v1.2 | Patent-protected † |
| wallet-foundation | Lux Ecosystem v1.2 | Patent-protected † |
| warp | Lux Ecosystem v1.2 | Patent-protected † |

`†` flags repositories slated for re-classification to BSD-3-Clause once the
first executed commercial-license artifact is in place. Until then the
binding tier is the one in the repo's `LICENSE` file. Treat the LICENSE as
the authoritative source — this table is documentation.

Repositories not listed (web frontends, marketing assets, design files, etc.)
follow the license declared in their own `LICENSE` file. Common cases:
Apache-2.0 (`chat`, `iam`, `ledger`, `pulsar`, `pulsar-mptc`, `qzmq`,
`pqrns`, `pqsafe`, `securities`, `zapdb`, `onnx`); MIT (`assets`, `gui`,
`indexer`, `mock`, `pq`, `xwallet`, `dwallet`); GPL-3 (`erc-3643`,
`onchain-id`, `safe-frost`, `safe-ios`, `safe-wallet`, `uni-v2-subgraph`,
`uni-v3-subgraph`, `uni-v4-subgraph`); MPL-2.0 (`czmq`).

### Commercial licensing

| Tier | Contact |
|------|---------|
| Lux Ecosystem License v1.2 (Eco) | `licensing@lux.network` |
| Lux Research License with Patent Reservation | `oss@lux.network` |
| Private moat (C++/CUDA/MLX/FPGA) | `licensing@lux.network` |

The full text of every license is in the relevant repository's `LICENSE`
file. The text is binding; the table on this page is a navigational aid.

## Core Projects

### Blockchain Infrastructure
| Project | Description |
|---------|-------------|
| [node](https://github.com/luxfi/node) | Lux blockchain node -- multi-consensus, post-quantum ready |
| [standard](https://github.com/luxfi/standard) | Reference implementation of Teleport protocol and quantum signatures |
| [teleport](https://github.com/luxfi/teleport) | Zero-knowledge MPC cross-chain bridge |
| [coreth](https://github.com/luxfi/coreth) | C-Chain EVM implementation |
| [evm](https://github.com/luxfi/evm) | Subnet EVM framework |

### Applications
| Project | Description |
|---------|-------------|
| [bank](https://github.com/luxfi/bank) | Open source banking-as-a-service platform |
| [exchange](https://github.com/luxfi/exchange) | AMM + DEX |
| [explorer](https://github.com/luxfi/explorer) | Block explorer |
| [market](https://github.com/luxfi/market) | Web3 marketplace for real-world assets (RWAs) |
| [wallet](https://github.com/luxfi/wallet) | HD wallet implementation |

### SDKs and Tools
| Project | Description |
|---------|-------------|
| [js-sdk](https://github.com/luxfi/js-sdk) | Lux JavaScript SDK |
| [sdk](https://github.com/luxfi/sdk) | Multi-language SDK (Go, TypeScript, Python) |
| [cli](https://github.com/luxfi/cli) | Command-line interface |
| [netrunner](https://github.com/luxfi/netrunner) | Network testing and simulation tool |

## Ecosystem

| Organization | Focus | Link |
|---|---|---|
| **Hanzo AI** | AI infrastructure, LLM gateway, MCP tools | [github.com/hanzoai](https://github.com/hanzoai) |
| **Lux Network** | Post-quantum blockchain, FHE, multi-consensus | [github.com/luxfi](https://github.com/luxfi) |
| **Zen LM** | Frontier language models, 600M-480B parameters | [github.com/zenlm](https://github.com/zenlm) |
| **Zoo Labs** | Open AI research, DeSci, 501(c)(3) foundation | [github.com/zoo-labs](https://github.com/zoo-labs) |
| **Lux FHE** | Fully homomorphic encryption research + SDK | [github.com/luxfhe](https://github.com/luxfhe) |
| **Lux C++** | High-performance C++ libraries (private moat) | [github.com/luxcpp](https://github.com/luxcpp) |
| **Hanzo KMS** | Enterprise secret management | [github.com/hanzokms](https://github.com/hanzokms) |
| **Hanzo ID** | Identity, OAuth2/OIDC, WebAuthn | [github.com/hanzoid](https://github.com/hanzoid) |

### Links
- [Papers](https://github.com/luxfi/papers) -- 329+ research papers
- [Stats](https://zeekay.github.io/stats/) -- 38,906+ commits, 59M net LOC
- [Security](https://github.com/luxfi/node/blob/main/SECURITY.md) -- cryptographic audit trail
- [History](https://github.com/luxfi/node/blob/main/HISTORY.md) -- 2008-2026 timeline

## Resources

- [lux.network](https://lux.network) -- Website
- [docs.lux.network](https://docs.lux.network) -- Documentation
- [explorer.lux.network](https://explorer.lux.network) -- Block explorer

*Built by the Lux team in collaboration with [Hanzo AI](https://hanzo.ai)*
