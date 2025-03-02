// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {CoinFlip} from "../src/CoinFlip.sol";

contract CoinFlipTest is Test {
    CoinFlip coinFlip;

    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    address user = makeAddr("user");

    function setUp() public {
        coinFlip = new CoinFlip();
    }

    function testFlip() public {
        vm.startPrank(user);
        for (uint256 i = 0; i < 10; i++) {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 outcome = blockValue / FACTOR;
        bool side = outcome == 1 ? true : false;
        coinFlip.flip(side);
        vm.roll(block.number + 1);
        }
        vm.stopPrank();

        console.log("Consecutive wins: ", coinFlip.consecutiveWins());
        assert(coinFlip.consecutiveWins() == 10);
    }

}