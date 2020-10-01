// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {SafeMath} from '@openzeppelin/contracts/math/SafeMath.sol';
import {Strings} from './Strings.sol';
import {Constants} from './Constants.sol';
import {SATs} from './SATs.sol';

library Discover {
    enum DiscoveryLevels {
        OnlyFederation,
        OnlyAlien,
        AlienAndFederation,
        OnlyAncient,
        OnlyAi,
        AllButAncient,
        All
    }

    function federationShips(uint256 amount)
        internal
        returns (SATs.Info memory)
    {
        uint256[8] memory _ids = SATs.getFederationShips();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return SATs.Info({id: _id, amount: amount});
    }

    function singleFederationShip(uint256 amount)
        internal
        returns (SATs.Info memory)
    {
        uint256[8] memory _ids = SATs.getFederationShips();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return SATs.Info({id: _id, amount: 1});
    }

    function singleAncientMiningShip() internal returns (SATs.Info memory) {
        uint256[3] memory _ids = SATs.getAncientMiningShip();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return SATs.Info({id: _id, amount: 1});
    }

    function singleAllNonAncientShips() internal returns (SATs.Info memory) {
        uint256[24] memory _ids = SATs.getAllNonAncientShips();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return SATs.Info({id: _id, amount: 1});
    }
}
