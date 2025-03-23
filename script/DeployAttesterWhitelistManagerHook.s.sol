

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import { Script } from "forge-std/Script.sol";
import { WhitelistManager } from "../src/WhitelistManager.sol";
import { AttesterWhitelistHook } from "../src/AttesterWhitelistHook.sol";

/// @title DeployAttesterWhitelistManagerHook
/// @notice Foundry deployment script for WhitelistManager and AttesterWhitelistHook
contract DeployAttesterWhitelistManagerHook is Script {
    
    function run() external {
        // Start broadcasting transactions (Foundry will use a private key)
        vm.startBroadcast();

        // Deploy the WhitelistManager contract
        WhitelistManager whitelistManager = new WhitelistManager();

        // Deploy the AttesterWhitelistHook contract with the address of WhitelistManager
        AttesterWhitelistHook attesterWhitelistHook = new AttesterWhitelistHook(address(whitelistManager));

        // Stop broadcasting transactions
        vm.stopBroadcast();

    }
}
