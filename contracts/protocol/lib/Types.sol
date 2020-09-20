// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from "@openzeppelin/contracts/math/SafeMath.sol";
import {Math} from "./Math.sol";

/**
 * @title Types
 * @author dYdX
 *
 * Library for interacting with the basic structs used in Solo
 */
library Types {
    using Math for uint256;

    // Individual token amount for an account
    struct Wei {
        bool sign; // true if positive
        uint256 value;
    }

    function zeroWei() internal pure returns (Wei memory) {
        return Wei({sign: false, value: 0});
    }

    function sub(Wei memory a, Wei memory b)
        internal
        pure
        returns (Wei memory)
    {
        return add(a, negative(b));
    }

    function add(Wei memory a, Wei memory b)
        internal
        pure
        returns (Wei memory)
    {
        Wei memory result;
        if (a.sign == b.sign) {
            result.sign = a.sign;
            result.value = SafeMath.add(a.value, b.value);
        } else {
            if (a.value >= b.value) {
                result.sign = a.sign;
                result.value = SafeMath.sub(a.value, b.value);
            } else {
                result.sign = b.sign;
                result.value = SafeMath.sub(b.value, a.value);
            }
        }
        return result;
    }

    function equals(Wei memory a, Wei memory b) internal pure returns (bool) {
        if (a.value == b.value) {
            if (a.value == 0) {
                return true;
            }
            return a.sign == b.sign;
        }
        return false;
    }

    function negative(Wei memory a) internal pure returns (Wei memory) {
        return Wei({sign: !a.sign, value: a.value});
    }

    function isNegative(Wei memory a) internal pure returns (bool) {
        return !a.sign && a.value > 0;
    }

    function isPositive(Wei memory a) internal pure returns (bool) {
        return a.sign && a.value > 0;
    }

    function isZero(Wei memory a) internal pure returns (bool) {
        return a.value == 0;
    }
}
