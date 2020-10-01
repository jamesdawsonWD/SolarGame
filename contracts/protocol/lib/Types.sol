// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Math} from './Math.sol';
import {Constants} from './Constants.sol';

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

    struct StarPosition {
        uint8 quadrant;
        uint8 distract;
        uint8 sector;
        uint32 star;
    }

    function isEqual(StarPosition memory a, StarPosition memory b)
        internal
        returns (bool)
    {
        return (a.quadrant == b.quadrant &&
            a.distract == b.distract &&
            a.sector == b.sector &&
            a.star == b.star);
    }

    function isEqualUint(uint256 a, uint256 b) internal returns (bool) {
        return a == b;
    }

    function notSet(StarPosition memory a) internal returns (bool) {
        return (a.quadrant == 0 ||
            a.distract == 0 ||
            a.sector == 0 ||
            a.star == 0);
    }

    function isWithinBoundaries(StarPosition memory a) internal returns (bool) {
        if (a.quadrant <= 0 || a.quadrant > Constants.MAX_QUADRANT)
            return false;
        if (a.distract <= 0 || a.distract > Constants.MAX_DISTRACT)
            return false;
        if (a.sector <= 0 || a.sector > Constants.MAX_SECTOR) return false;
        if (a.star <= 0 || a.star > Constants.MAX_STAR) return false;
        return true;
    }
}
