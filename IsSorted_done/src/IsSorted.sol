// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";

contract IsSorted {
    /**
     * The goal of this exercise is to return true if the members of "arr" is sorted (in ascending order) or false if its not.
     */
    function isSorted(uint256[] calldata arr) public view returns (bool) {
        // your code here

        for (uint i = 0; i < arr.length - 1; i++) {
            if (arr[i] > arr[i + 1]) {
                return false;
            }
        }
        return true;
    }
}