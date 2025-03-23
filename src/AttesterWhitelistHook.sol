// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { IERC20 } from "@openzeppelin/contracts/interfaces/IERC20.sol";
//import { IERC20 } from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/interfaces/IERC20.sol";

import { WhitelistManager } from "./WhitelistManager.sol";

 
/// @title 3wb.club attester whitelist hook V1.0
/// @notice hook contract that allows only whitelisted attester interaction with Sign Protocol Schema
/// @author Geeloko x Team Sign 



interface ISPHook {
    function didReceiveAttestation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        bytes calldata extraData
    )
        external
        payable;

    function didReceiveAttestation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        IERC20 resolverFeeERC20Token,
        uint256 resolverFeeERC20Amount,
        bytes calldata extraData
    )
        external;

    function didReceiveRevocation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        bytes calldata extraData
    )
        external
        payable;

    function didReceiveRevocation(
        address attester,
        uint64 schemaId,
        uint64 attestationId,
        IERC20 resolverFeeERC20Token,
        uint256 resolverFeeERC20Amount,
        bytes calldata extraData
    )
        external;
}

// @dev This contract implements the actual schema hook.
contract AttesterWhitelistHook is ISPHook {
    WhitelistManager public whitelistManager;

    /// @notice Initializes the hook with the address of the WhitelistManager.
    /// @param _whitelistManager The address of the deployed WhitelistManager contract.
    constructor(address _whitelistManager) {
        whitelistManager = WhitelistManager(_whitelistManager);
    }

    function didReceiveAttestation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        bytes calldata // extraData
    )
        external
        payable
    {
        whitelistManager._checkAttesterWhitelistStatus(attester);
    }

    function didReceiveAttestation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        view
    {
        whitelistManager._checkAttesterWhitelistStatus(attester);
    }

    function didReceiveRevocation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        bytes calldata // extraData
    )
        external
        payable
    {
        whitelistManager._checkAttesterWhitelistStatus(attester);
    }

    function didReceiveRevocation(
        address attester,
        uint64, // schemaId
        uint64, // attestationId
        IERC20, // resolverFeeERC20Token
        uint256, // resolverFeeERC20Amount
        bytes calldata // extraData
    )
        external
        view
    {
        whitelistManager._checkAttesterWhitelistStatus(attester);
    }
}