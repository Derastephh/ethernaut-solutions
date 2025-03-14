## ETHERNAUT SOLUTIONS

Solutions to [Ethernaut CTF](https://ethernaut.openzeppelin.com/) challenges ⛳️

## CONTENTS

1. [Fallback](#1---fallback)
2. [Fallout](#2---fallout)
3. [Coin Flip](#3---coinflip)
4. [Telephone](#4---telephone)
5. [Token](#5---token)
6. [Delegation](#6---delegation)
7. [Force](#7---force)
8. [Vault](#8---vault)
9. [King](#9---king)

## 1 - Fallback

Our objectives is to claim ownership of this contract and drain it's ETH.

Taking a look at the receive function:

```javascript
receive() external payable {
        require(msg.value > 0 && contributions[msg.sender] > 0);
        owner = msg.sender;
    }
```
 We only have to make at least 1 wei of contribution, send any eth greater than 0 and we become the new owner of the contract. Now we can call the withdraw function and drain the contract.

 [Test](https://github.com/Derastephh/ethernaut-solutions/blob/main/test/FallbackTest.t.sol)

## 2 - Fallout

The goal of the Ethernaut Fallout challenge is to claim ownership of the contract.

There is a suspicious line in the first function:

```javascript
function Fal1out() public payable {
        owner = msg.sender;
        allocations[owner] = msg.value;
    }
```
Anyone can call the below function and therefore claim ownership of the contract:

[Test](https://github.com/Derastephh/ethernaut-solutions/blob/main/test/FallOutTest.t.sol)

## 3 - CoinFlip

This is a coin flipping game where you need to build up your winning streak by guessing the outcome of a coin flip. To complete this level you'll need to use your psychic abilities to guess the correct outcome 10 times in a row.

This contract relies on blockhash(block.number - 1), which is predictable, making it vulnerable to an attacker who can calculate the correct outcome before calling flip

[Test](https://github.com/Derastephh/ethernaut-solutions/blob/main/test/CoinFlipTest.t.sol)

## 9 - King

In this challenge, the goal is to become the new king and prevent others from becoming a king.

Anyone that sends a bigger msg.value than the previous king becomes the new king and the contract sends the former prize to the previous king.

We can send ether from a malicious contract with no receive or fallback function, thereby breaking the king contract and remaining the undisputed king.

[Test](https://github.com/Derastephh/ethernaut-solutions/blob/main/test/KingTest.sol)