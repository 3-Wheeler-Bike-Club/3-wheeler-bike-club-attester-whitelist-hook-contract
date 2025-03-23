// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
//import { Ownable } from "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

 
/// @title 3wb.club attester whitelist hook V1.0
/// @notice hook contract that allows only whitelisted attester interaction with Sign Protocol Schema
/// @author Geeloko x Team Sign 

// @dev This contract manages the whitelist. We are separating the whitelist logic from the hook to make things easier
// to read.
contract WhitelistManager is Ownable {
    mapping(address attester => bool allowed) public whitelist;

    error UnauthorizedAttester();

    constructor() Ownable(_msgSender()) { }

    function setWhitelist(address attester, bool allowed) external onlyOwner {
        whitelist[attester] = allowed;
    }

    function _checkAttesterWhitelistStatus(address attester) external view {
        // solhint-disable-next-line custom-errors
        require(whitelist[attester], UnauthorizedAttester());
    }
}
