// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.0;

import {Script} from "forge-std/Script.sol";
import {Fallout} from "../src/Fallout.sol";

contract DeployFallout is Script {
    Fallout public falloutContract;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        falloutContract = new Fallout();

        vm.stopBroadcast();
    }
}
