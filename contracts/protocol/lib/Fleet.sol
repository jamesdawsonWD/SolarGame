// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Types} from './Types.sol';

/**
 * @title Exchange
 * @author Big Beluga
 *
 * Library for transferring tokens and interacting with ExchangeWrappers by using the Wei struct
 */
library Fleet {
    using SafeMath for uint256;

    enum Orders {Attack, Defend}
    struct Info {
        Types.StarPosition position;
        mapping(uint256 => uint256) shipsAndTechnology;
        Orders orders;
    }
}
