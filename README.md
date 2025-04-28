# 3WB Attester Whitelist Hook Contract

A Solidity hook contract for the Sign Protocol that restricts attestation capabilities to a configurable whitelist of approved attester addresses.

## 🚀 Key Features

- **Whitelist Management**: Owner-only functions to add or remove multiple addresses in batch.
- **Enforced Hook**: Implements `AttesterRegistryHook` (or equivalent) to validate whitelist membership before allowing attestations.
- **Ownership Control**: Inherits `Ownable`—only the contract owner can modify the whitelist.
- **View Utilities**: Query whether an address is whitelisted and retrieve the full whitelist.

## 📋 Public API

| Function                                                   | Accessibility | Description                                                 |
| ---------------------------------------------------------- | ------------- | ----------------------------------------------------------- |
| `addAttesters(address[] calldata addrs)`                   | onlyOwner     | Batch-add addresses to the whitelist.                       |
| `removeAttesters(address[] calldata addrs)`                | onlyOwner     | Batch-remove addresses from the whitelist.                  |
| `isAttesterWhitelisted(address addr) external view`        | public view   | Returns `true` if `addr` is currently whitelisted.         |
| `getAllWhitelisted() external view returns (address[] )`   | public view   | Returns the full list of whitelisted attester addresses.    |
| `preHook(address attester, bytes calldata data) external`  | hook entry    | Called by Sign Protocol before attestation; reverts if `attester` not whitelisted. |

## 🛠 Setup & Deployment

### Prerequisites

- [Foundry](https://book.getfoundry.sh/) (`forge`, `anvil`)
- Node.js (for any auxiliary scripts)
- A Celo or Ethereum RPC endpoint and deployer private key

### Clone & Build

```bash
git clone https://github.com/3-Wheeler-Bike-Club/3-wheeler-bike-club-attester-whitelist-hook-contract.git
cd 3-wheeler-bike-club-attester-whitelist-hook-contract

# Ensure Foundry is up to date
foundryup

# Compile the contract
forge build
```

### Testing

```bash
forge test
```

### Deployment

1. Create a `.env` in the project root:

   ```env
   RPC_URL=https://forno.celo.org    # or your preferred RPC
   PRIVATE_KEY=0xYOUR_DEPLOYER_KEY
   ```

2. Deploy with Forge script:

   ```bash
   forge script scripts/DeployWhitelistHook.s.sol \
     --rpc-url $RPC_URL \
     --private-key $PRIVATE_KEY \
     --broadcast
   ```

3. Copy the deployed hook contract address for registry configuration.

## 📁 Project Structure

```bash
/
├── src/
│   └── AttesterWhitelistHook.sol    # Main hook contract
├── scripts/
│   └── DeployWhitelistHook.s.sol    # Deployment script
├── foundry.toml                    # Foundry configuration
├── remappings.txt                  # Dependency remappings
└── README.md                       # This file
```

## 🤝 Contributing

1. Fork the repo and create a branch (`git checkout -b feature/...`).
2. Add or modify functionality with accompanying tests.
3. Commit changes and open a Pull Request describing your updates.

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
```

