// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract ReducingPayout {
    /*
        This exercise assumes you know how block.timestamp works.
        1. This contract has 1 ether in it, each second that goes by, 
           the amount that can be withdrawn by the caller
           goes from 100% to 0% as 24 hours passes.
        2. Implement your logic in `withdraw` function.
        Hint: 1 second deducts 0.0011574% from the current %.
    */

    // The time 1 ether was sent to this contract
    uint256 public immutable depositedTime;
    address public immutable owner;

    constructor() payable {
        owner = msg.sender;
        depositedTime = block.timestamp;
    }

    function withdraw() public {
        // your code here 24hr = 86400
        // 1 eth - 11574074074074 = 999988425925925900
        // 7200 / 86400


        uint elapsedSeconds = block.timestamp - depositedTime;
        uint amountToDeduct = (elapsedSeconds * 0.0011574 ether) / 100;
        uint remainingEther = 1 ether - amountToDeduct;

        if (elapsedSeconds >= 86400) {
            remainingEther = 0;
        }
        msg.sender.call{value: remainingEther}("");
    }
}
