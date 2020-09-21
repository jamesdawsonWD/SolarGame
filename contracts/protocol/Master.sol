// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Getters} from './Getters.sol';
import {TsunoToken} from './TsunoToken.sol';
import {State} from './State.sol';
import {Operations} from './Operations.sol';

contract Master is State, Operations, Getters {
    constructor(address _tsuno) public {
        g_state.tsuno = _tsuno;
    }
}
