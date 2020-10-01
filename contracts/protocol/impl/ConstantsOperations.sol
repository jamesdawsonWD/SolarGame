// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Events} from '../lib/Events.sol';
import {Storage} from '../lib/Storage.sol';
import {ISolar} from '../interfaces/ISolar.sol';
import {Rewards} from '../lib/Rewards.sol';
import {Types} from '../lib/Types.sol';

/**
 * @title Constants Operations
 * @author James Dawson
 *
 * Primary public functions for changing the state of the games constant variables.
 * Can only be triggered by a goverance vote.
 */
library ConstantsOperations {
    using SafeMath for uint256;
    using Storage for Storage.State;

    function startPosition(
        Storage.State storage state,
        Types.StarPosition memory pos
    ) public {
        Types.StarPosition memory from = state.getMasterFleetPosition(
            msg.sender
        );
    }

    function shipAndTechOffense(
        Storage.State storage state,
        uint256[] memory _ids,
        uint8[] memory _offence
    ) public {
        require(
            _ids.length == _offence.length,
            'Offense numbers and IDs must match in length'
        );
        for (uint256 i = 0; i < _ids.length; i++) {
            state.setSatOffense(_ids[i], _offence[i]);
        }
    }

    function shipAndTechAttack(
        Storage.State storage state,
        uint256[] memory _ids,
        uint8[] memory _defences
    ) public {
        require(
            _ids.length == _defences.length,
            'Attacks and IDs must match in length'
        );
        for (uint256 i = 0; i < _ids.length; i++) {
            state.setSatDefense(_ids[i], _defences[i]);
        }
    }

    // function boundaries(Storage.State storage state, Types.StarPosition pos)
    //     public
    // {
    //     state.setBoundaries(pos);
    // }

    // function battle(Storage.State storage state, Constants.Battle info) public {
    //     state.setBattleInfo(info);
    // }

    // function gas(Storage.State storage state, Constants.Gas info) public {
    //     state.setGas(info);
    // }
}
