# Lux Network 🌐

**Multi-consensus blockchain with post-quantum security**

Lux is a high-performance blockchain platform featuring novel consensus mechanisms, post-quantum cryptography, and seamless cross-chain interoperability.

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      Lux Network                                │
├─────────────────────────────────────────────────────────────────┤
│  ┌─────────────┬─────────────┬─────────────┬─────────────┐      │
│  │   X-Chain   │   P-Chain   │   C-Chain   │  Subnets    │      │
│  │   (DAG)     │  (Platform) │    (EVM)    │  (Custom)   │      │
│  └─────────────┴─────────────┴─────────────┴─────────────┘      │
│                              │                                   │
│  ┌───────────────────────────────────────────────────────┐      │
│  │              Snow Consensus Family                     │      │
│  │  Snowball • Snowflake • Avalanche • Frosty            │      │
│  └───────────────────────────────────────────────────────┘      │
│                              │                                   │
│  ┌───────────────────────────────────────────────────────┐      │
│  │           Post-Quantum Cryptography                    │      │
│  │  Lattice-based signatures • FHE • Threshold MPC       │      │
│  └───────────────────────────────────────────────────────┘      │
└─────────────────────────────────────────────────────────────────┘
```

## 📦 Core Repositories

### Blockchain Infrastructure
| Repository | Description | Language |
|------------|-------------|----------|
| [node](https://github.com/luxfi/node) | Lux node implementation | Go |
| [coreth](https://github.com/luxfi/coreth) | C-Chain EVM implementation | Go |
| [subnet-evm](https://github.com/luxfi/subnet-evm) | Subnet EVM framework | Go |
| [cli](https://github.com/luxfi/cli) | Command-line interface | Go |
| [netrunner](https://github.com/luxfi/netrunner) | Network testing tool | Go |

### Cryptography & Security
| Repository | Description | Language |
|------------|-------------|----------|
| [fhe](https://github.com/luxfi/fhe) | Fully Homomorphic Encryption | Go |
| [lattice](https://github.com/luxfi/lattice) | Lattice cryptography | Go |
| [torus](https://github.com/luxfi/torus) | FHE compiler & runtime | Python/C++ |
| [torus-ml](https://github.com/luxfi/torus-ml) | ML on encrypted data | Python |
| [fhe-compiler](https://github.com/luxfi/fhe-compiler) | LLVM FHE compiler | C++ |

### SDKs & Tools
| Repository | Description | Language |
|------------|-------------|----------|
| [sdk](https://github.com/luxfi/sdk) | Multi-language SDK | Go/TS/Py |
| [wallet](https://github.com/luxfi/wallet) | HD wallet implementation | Go/TS |
| [bridge](https://github.com/luxfi/bridge) | Cross-chain bridge | Go |
| [explorer](https://github.com/luxfi/explorer) | Block explorer | TypeScript |

## 🔐 FHE Ecosystem

Lux provides the most comprehensive FHE stack:

| Component | Purpose | Repo |
|-----------|---------|------|
| **Core** | FHE operations | [luxfi/fhe](https://github.com/luxfi/fhe) |
| **Lattice** | Cryptographic primitives | [luxfi/lattice](https://github.com/luxfi/lattice) |
| **Torus** | Python/C++ compiler | [luxfi/torus](https://github.com/luxfi/torus) |
| **Torus-ML** | Encrypted ML | [luxfi/torus-ml](https://github.com/luxfi/torus-ml) |
| **LLVM Compiler** | Multi-language | [luxfi/fhe-compiler](https://github.com/luxfi/fhe-compiler) |

**Documentation & Examples:** [github.com/luxfhe](https://github.com/luxfhe)

## 🚀 Quick Start

### Run a Node
```bash
# Install CLI
go install github.com/luxfi/cli@latest

# Create local network
lux network start

# Deploy subnet
lux subnet create mysubnet
lux subnet deploy mysubnet
```

### Use FHE
```go
import "github.com/luxfi/fhe"

client, _ := fhe.NewClient()
encrypted := client.Encrypt(42)
// Compute on encrypted data...
```

## 🔗 Related Organizations

| Organization | Focus | Link |
|--------------|-------|------|
| **Lux Network** | Blockchain infrastructure | [github.com/luxfi](https://github.com/luxfi) |
| **Lux FHE** | FHE docs & examples | [github.com/luxfhe](https://github.com/luxfhe) |
| **Lux C++** | C++ implementations | [github.com/luxcpp](https://github.com/luxcpp) |
| **Hanzo AI** | AI infrastructure | [github.com/hanzoai](https://github.com/hanzoai) |
| **Zen LM** | Frontier models | [github.com/zenlm](https://github.com/zenlm) |

## 📚 Resources

- **Website:** [lux.network](https://lux.network)
- **Docs:** [docs.lux.network](https://docs.lux.network)
- **FHE Docs:** [fhe.lux.network](https://fhe.lux.network)
- **Explorer:** [explorer.lux.network](https://explorer.lux.network)

## 📄 License

Apache 2.0 - See individual repositories for details.

---

**Built by the Lux team in collaboration with [Hanzo AI](https://hanzo.ai)**
