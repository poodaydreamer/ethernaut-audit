// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {Fallback} from "../src/Fallback.sol";

contract DeployFallback is Script {
    Fallback public fallbackContract;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        fallbackContract = new Fallback();

        vm.stopBroadcast();
    }
}
