// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

contract TimelockEscrow {
    address public seller;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes.
     * Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    uint escrowTimeWindow;
    uint escrowBalance;
    mapping(address => uint) public deposits;

    constructor() payable {
        seller = msg.sender;
    }

    // creates a buy order between msg.sender and seller
    /**
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {

        require(escrowBalance == 0, "escrow hasn't been withdrawn");
        require(escrowTimeWindow == 0, "active escrow still exists");

        escrowBalance = msg.value;
        deposits[msg.sender] = escrowBalance;
        escrowTimeWindow = block.timestamp + 3 days;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        //owner/seller can not withdray within 3 days
        require(block.timestamp >= escrowTimeWindow);
//        address(seller).call{value: escrowBalance}("");
        payable(seller).transfer(address(seller).balance);
    }

    /**
     * allowa buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // buyer can not withraw after 3 days
        require(block.timestamp < escrowTimeWindow);
        require(msg.sender != address(seller), "only buyer can withdraw");

        payable(msg.sender).transfer(address(seller).balance);
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return deposits[buyer];
    }
}
