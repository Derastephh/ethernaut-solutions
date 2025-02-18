// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import { Test, console } from "forge-std/Test.sol";
import {King, AttackSelfDestructMe} from "../src/King.sol";

contract KingTest is Test {
    King king;
    AttackSelfDestructMe asdm;

    address user = makeAddr("user");
    address user2 = makeAddr("user2");

    function setUp() public {
        king = new King();
        asdm = new AttackSelfDestructMe(king);

        vm.deal(user, 10 ether);
        vm.deal(user2, 10 ether);
    }

    function testForcefullyBecomeOwner() public {

        vm.prank(user2);
        payable(king).call{value: 2 ether}("");

        console.log("former king:", king._king());
        console.log("user2", address(user2));
        console.log("Former Prize:", king.prize());

        vm.prank(user);
        asdm.attack{value: 3 ether}();

        console.log("new king:", king._king());
        console.log("Attacker contract:", address(asdm));
        console.log("New Prize:", king.prize());
    }

    receive() external payable {}

    fallback() external payable {}
}