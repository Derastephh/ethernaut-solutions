// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test, console } from "forge-std/Test.sol";
import {Fallout} from "../src/FallOut.sol";

contract FallOutTest is Test {
    Fallout fallOut;
    address user = makeAddr("user");

    function setUp() public {
        fallOut = new Fallout();
    }

    function testClaimOwnership() public {
        vm.prank(user);
        fallOut.Fal1out();

        assert(fallOut.owner() == address(user));
    }
}