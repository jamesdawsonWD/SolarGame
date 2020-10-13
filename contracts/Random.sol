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

    function randomrange(
        uint256 a,
        uint256 b,
        uint256 nonce
    ) internal returns (uint256) {
        uint256 randomnumber = uint256(keccak256(abi.encodePacked(seed * nonce))) % b;
        randomnumber = randomnumber + a;
        return randomnumber;
    }

    function setSeed(uint256 _seed) public {
        seed = _seed;
    }

    function rand(uint256 _seed) internal pure returns (uint256) {
        bytes32 data;
        if (_seed % 2 == 0) {
            data = keccak256(abi.encode(bytes32(_seed)));
        } else {
            data = keccak256(abi.encode(keccak256(abi.encode(bytes32(_seed)))));
        }
        uint256 sum;
        for (uint256 i; i < 32; i++) {
            sum += uint256(uint8(data[i]));
        }
        return
            uint256(uint8(data[sum % data.length])) * uint256(uint8(data[(sum + 2) % data.length]));
    }

    /**
     * @dev Generate random uint <= 256^2 with seed = block.timestamp
     * @return uint
     */
    // TODO: improve this randomness by using a nonce
    function randint() internal view returns (uint256) {
        return rand(now * block.number);
    }

    /**
     * @dev Generate random uint in range [a, b]
     * @return uint
     */
    function randrange(uint256 a, uint256 b) internal view returns (uint256) {
        return a + (randint() % b);
    }

    /**
     * @dev Generate array of random bytes
     * @param size seed
     * @return byte[size]
     */
    function randbytes(uint256 size, uint256 seed) internal pure returns (bytes1[] memory) {
        bytes1[] memory data = new bytes1[](size);
        uint256 x = seed;
        for (uint256 i; i < size; i++) {
            x = rand(x);
            data[i] = bytes1(uint8(x % 256));
        }
        return data;
    }
}
