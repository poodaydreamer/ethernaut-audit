// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import {Script} from "forge-std/Script.sol";
import "forge-std/console2.sol";
import {Delegate} from "../src/Delegate.sol";
import {Delegation} from "../src/Delegation.sol";

contract DeployDelegation is Script {
    Delegation public delegationContract;

    function setUp() public {}

    function run() public {
        Delegate delegateContract;
        Delegation delegationContract;

        vm.startBroadcast();
        uint256 pk = vm.envUint("PRIVATE_KEY");
        address player = vm.addr(pk);

        console2.log("Derived Player Address:");
        console2.logAddress(player);

        // Deploy delegate contract first
        delegateContract = new Delegate(player);
        
        // output deployed delegate contract
        console2.log("Delegate Contract Address:");
        console2.logAddress(address(delegateContract));

        delegationContract = new Delegation(address(delegateContract));
        
        // output deployed delegation contract
        console2.log("Delegation Contract Address: ");
        console2.logAddress(address(delegationContract));

        vm.stopBroadcast();
    }
}
