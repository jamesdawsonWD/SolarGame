// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

/**
 * @title Exchange
 * @author Big Beluga
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
contract Random {
    uint256 private seed;
    uint256 nonce = 1;
    event Random(uint256 random);

    function randomrange(uint256 a, uint256 b) internal returns (uint256 randomnumber) {
        randomnumber = uint256(keccak256(abi.encodePacked(now, msg.sender, seed, nonce))) % b;
        randomnumber = randomnumber < a ? randomnumber + a : randomnumber;
        nonce++;
        return randomnumber;
    }

    function setSeed(uint256 _seed) public {
        seed = _seed;
    }
}
