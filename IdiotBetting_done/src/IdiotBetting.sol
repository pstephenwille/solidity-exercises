// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract IdiotBettingGame {
    /*
        This exercise assumes you know how block.timestamp works.
        - Whoever deposits the most ether into a contract wins all the ether
            if no-one  else deposits after an hour.
        1. `bet` function allows users to deposit ether into the contract. 
           If the deposit is higher than the previous highest deposit,
           the endTime is updated by current time + 1 hour,
           the highest deposit and winner are updated.
        2. `claimPrize` function can only be called by the winner
            after the betting period has ended.
            It transfers the entire balance of the contract to the winner.
    */

    uint private lastDepositTime;
    uint private lastDepositedAmount;
    address private winners;

    function bet() public payable {
        if (msg.value > lastDepositedAmount)
        {
            lastDepositTime = block.timestamp + 1 hours;
            winners = msg.sender;
        }
        address(this).call{value: msg.value}("");
        lastDepositedAmount = msg.value;
    }

    function claimPrize() public {
        require(block.timestamp > lastDepositTime, "too early to claim prize");
        require(winners == msg.sender, "not the winner");
        payable(msg.sender).transfer(address(this).balance);
    }
}
