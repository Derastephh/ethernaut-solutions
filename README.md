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

## 9 - King

In this challenge, the goal is to become the new king and prevent others from becoming a king.

Anyone that sends a bigger msg.value than the previous king becomes the new king and the contract sends the former prize to the previous king.

We can send ether from a malicious contract with no receive or fallback function, thereby breaking the king contract and remaining the undisputed king.

[Test](https://github.com/Derastephh/ethernaut-solutions/blob/main/test/KingTest.sol)