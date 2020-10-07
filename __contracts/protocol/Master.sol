// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Getters} from './Getters.sol';
import {State} from './State.sol';
import {Operations} from './Operations.sol';
import {Admin} from './Admin.sol';
import {EternalStorage} from './EternalStorage';

contract Master is State, Operations, Getters, Admin {
    constructor(address _es, address _fhr, address _solar, address _sats) {
        EternalStorage(eternalStorage).setAddress(keccak256("contract.address", "FHR"), _fhr);
        EternalStorage(eternalStorage).setAddress(keccak256("contract.address", "Solar"), _solar);
        EternalStorage(eternalStorage).setAddress(keccak256("contract.address", "SATs"), _sats);
    }
}
