// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Getters} from './Getters.sol';
import {State} from './State.sol';
import {Operations} from './Operations.sol';
import {Admin} from './Admin.sol';

contract Master is State, Operations, Getters, Admin {}
