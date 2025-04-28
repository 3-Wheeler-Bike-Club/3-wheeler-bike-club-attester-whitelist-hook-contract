# 3WB Attester Whitelist Hook Contracts

This repository contains two Solidity contracts for the Sign Protocol:

1. **WhitelistManager**: Manages a whitelist of approved attester addresses.  
2. **AttesterWhitelistHook**: A Sign Protocol hook that enforces whitelist checks before attestations or revocations.

---

## 📜 Contracts

### 1. WhitelistManager.sol

A standalone contract that stores and manages a whitelist of addresses authorized to act as attesters.

**Key Features:**
- Owner-controlled: only the owner can update whitelist entries.  
- Simple boolean mapping: `whitelist[attester]` indicates permission.
- Custom error `UnauthorizedAttester()` for clearer reverts.

**Public API:**
```solidity
/// @notice Enable or disable an attester address.
/// @param attester The address to update.
/// @param allowed `true` to whitelist, `false` to remove.
function setWhitelist(address attester, bool allowed) external onlyOwner;

/// @notice View whether an address is whitelisted.
/// @param attester The address to check.
function whitelist(address attester) external view returns (bool allowed);

/// @notice Internal check that reverts if address not whitelisted.
/// @param attester The address to validate.
function _checkAttesterWhitelistStatus(address attester) external view;
```

### 2. AttesterWhitelistHook.sol

A Sign Protocol hook that calls into `WhitelistManager` to enforce whitelist rules before any attestation or revocation.

**Key Features:**
- Leverages `WhitelistManager._checkAttesterWhitelistStatus` to revert unauthorized calls.  
- Compatible with both ETH and ERC20 fee variants of `didReceiveAttestation` and `didReceiveRevocation`.

**Public API (from `ISPHook` interface):**
```solidity
/// @notice Called after an attestation with native ETH fee.
function didReceiveAttestation(
    address attester,
    uint64 schemaId,
    uint64 attestationId,
    bytes calldata extraData
) external payable;

/// @notice Called after an attestation with ERC20 fee.
function didReceiveAttestation(
    address attester,
    uint64 schemaId,
    uint64 attestationId,
    IERC20 resolverFeeERC20Token,
    uint256 resolverFeeERC20Amount,
    bytes calldata extraData
) external view;

/// @notice Called after a revocation with native ETH fee.
function didReceiveRevocation(
    address attester,
    uint64 schemaId,
    uint64 attestationId,
    bytes calldata extraData
) external payable;

/// @notice Called after a revocation with ERC20 fee.
function didReceiveRevocation(
    address attester,
    uint64 schemaId,
    uint64 attestationId,
    IERC20 resolverFeeERC20Token,
    uint256 resolverFeeERC20Amount,
    bytes calldata extraData
) external;
```

---

## 🛠️ Setup & Deployment

### Prerequisites

- [Foundry](https://book.getfoundry.sh/) (`forge`, `anvil`) installed  
- Node.js (for any JS scripts)  
- A Celo or Ethereum RPC endpoint and deployer private key

### Installation & Build

```bash
git clone https://github.com/3-Wheeler-Bike-Club/3-wheeler-bike-club-attester-whitelist-hook-contract.git
cd 3-wheeler-bike-club-attester-whitelist-hook-contract

foundryup            # Update Foundry
forge build          # Compile contracts
```

### Testing

```bash
forge test
```

### Deployment

1. Create a `.env` file in project root:
```env
RPC_URL=https://forno.celo.org  # or Ethereum RPC
PRIVATE_KEY=0xYOUR_DEPLOYER_KEY
```
2. Deploy **WhitelistManager**:
```bash
forge script scripts/DeployWhitelistManager.s.sol \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast
```
3. Deploy **AttesterWhitelistHook**, passing the WhitelistManager address:
```bash
forge script scripts/DeployWhitelistHook.s.sol \
  --rpc-url $RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast \
  --constructor-args <WhitelistManagerAddress>
```
4. Register the hook address in your Sign Protocol registry.

---

## 📁 Project Structure

```bash
/
├── src/
│   ├── WhitelistManager.sol       # Manages whitelist entries
│   └── AttesterWhitelistHook.sol  # Sign Protocol hook enforcement
├── scripts/
│   ├── DeployWhitelistManager.s.sol   # Deploy script for manager
│   └── DeployWhitelistHook.s.sol      # Deploy script for hook
├── foundry.toml                    # Foundry config
├── remappings.txt                  # Solidity remappings
└── README.md                       # This file
```

---

## 🤝 Contributing

1. Fork the repo and create a branch (`git checkout -b feature/...`).  
2. Add or modify functionality along with tests.  
3. Commit, push, and open a Pull Request detailing your changes.

---

## 📄 License

MIT License. See [LICENSE](LICENSE) for details.
```

