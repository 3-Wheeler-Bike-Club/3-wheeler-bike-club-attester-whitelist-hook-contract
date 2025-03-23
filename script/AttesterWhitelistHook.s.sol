// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import {Script, console} from "forge-std/Script.sol";
import {AttesterWhitelistHook} from "../src/AttesterWhitelistHook.sol";

contract AttesterWhitelistHookScript is Script {
    AttesterWhitelistHook public attesterWhitelistHook;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        attesterWhitelistHook = new AttesterWhitelistHook();

        vm.stopBroadcast();
    }
}