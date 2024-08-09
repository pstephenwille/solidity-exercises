// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.24;

import "forge-std/Test.sol";

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit)
     * but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */

    uint private lastCalledAt;

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
       return user.balance;
    }

    function depositEther() external payable {
        /// add code here
        require(address(this) != address(0), "invalid address");
        address(this).call{value: msg.value}("");
        lastCalledAt = block.timestamp;
    }

    function withdrawEther(uint256 amount) external {
        /// add code here
        console.log('xxx', address(this).balance);
        require(block.timestamp > lastCalledAt + 1 weeks, "less than a week");
        require(amount <= address(this).balance, "not enough funds");

        msg.sender.call{value: amount}("");
        lastCalledAt = block.timestamp;

    }
}
