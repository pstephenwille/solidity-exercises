// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;
import {Test, console} from "forge-std/Test.sol";

contract Distribute {
    /*
        This exercise assumes you know how to sending Ether.
        1. This contract has some ether in it, distribute it equally among the
           array of addresses that is passed as argument.
        2. Write your code in the `distributeEther` function.
    */

    constructor() payable {}

    function distributeEther(address[] memory addresses) public {
        // your code here
        uint share = address(this).balance / 4;

        for(uint8 i=0; i<addresses.length; i++){
            addresses[i].call{value: share}("");
        }

    }
}
