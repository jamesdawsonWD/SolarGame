// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Storage} from './lib/Storage.sol';

/**
 * @title State
 * @author Big Beluga
 *
 * Base-level contract that holds the state
 */
contract State {
    Storage.State g_state;
}
