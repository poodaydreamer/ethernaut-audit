// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import {CoinFlip} from "../src/CoinFlip.sol";

contract DeployCoinFlip is Script {
    CoinFlip public coinFlip;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();

        coinFlip = new CoinFlip();

        vm.stopBroadcast();
    }
}
