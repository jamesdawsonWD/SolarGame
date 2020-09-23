// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Getters} from './Getters.sol';
import {TsunoToken} from './TsunoToken.sol';
import {State} from './State.sol';
import {Operations} from './Operations.sol';

contract Master is State, Operations, Getters {
    constructor(
        address _tsuno,
        address _solar,
        address _sat
    ) public {
        g_state.tsuno = _tsuno;
        g_state.solar = _solar;
        g_state.sat = _sat;
    }
}
