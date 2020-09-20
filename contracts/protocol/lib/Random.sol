// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

/**
 * @title Exchange
 * @author Big Beluga
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library Random {
    // ============ Constants ============

    bytes32 constant FILE = "Random";

    // ============ Library Functions ============

    /**
     * @dev Pseudo-random number generator
     */
    function rand(uint256 seed) internal returns (uint256) {
        uint256 randomNumber = uint256(
            keccak256(
                abi.encodePacked(blockhash(block.number - 1), msg.sender, seed)
            )
        );
        return randomNumber;
    }
}
