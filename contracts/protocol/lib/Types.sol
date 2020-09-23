// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Math} from './Math.sol';

/**
 * @title Types
 * @author dYdX
 *
 * Library for interacting with the basic structs used in Solo
 */
library Types {
    using Math for uint256;

    // TODO: Look into creating a constant library that can be passes into the library
    // this will allow for balancing tweaks in as the game progresses
    uint256 constant MAX_QUADRANT = 5;
    uint256 constant MAX_DISTRACT = 8;
    uint256 constant MAX_SECTOR = 21;
    uint256 constant MAX_STAR = 10000;

    struct SatInfo {
        uint256 amount;
        uint32 id;
    }

    struct StarPosition {
        uint8 quadrant;
        uint8 distract;
        uint8 sector;
        uint32 star;
    }

    function isEqualStarPosition(StarPosition memory a, StarPosition memory b)
        internal
        returns (bool)
    {
        return (keccak256(
            abi.encodePacked(a.quadrant, a.distract, a.sector, a.star)
        ) ==
            keccak256(
                abi.encodePacked(b.quadrant, b.distract, b.sector, b.star)
            ));
    }

    function isEqualUint(uint256 a, uint256 b) internal returns (bool) {
        return a == b;
    }

    function isWithinBoundaries(StarPosition memory a) internal returns (bool) {
        if (a.quadrant < 0 || a.quadrant > MAX_QUADRANT) return false;
        if (a.distract < 0 || a.distract > MAX_DISTRACT) return false;
        if (a.sector < 0 || a.sector > MAX_SECTOR) return false;
        if (a.star < 0 || a.star > MAX_STAR) return false;
        return true;
    }
}
