// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Random} from './Random.sol';
import {Types} from './lib/Types.sol';

contract Discovery is Random {
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
        returns (Types.SatInfo memory)
    {
        uint256[8] memory _ids = Types.getFederationShips();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: amount});
    }

    function singleFederationShip(uint256 amount)
        internal
        returns (Types.SatInfo memory)
    {
        uint256[8] memory _ids = Types.getFederationShips();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: 1});
    }

    function singleAncientMiningShip() internal returns (Types.SatInfo memory) {
        uint256[3] memory _ids = Types.getAncientMiningShip();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: 1});
    }

    function singleAllNonAncientShips()
        internal
        returns (Types.SatInfo memory)
    {
        uint256[24] memory _ids = Types.getAllNonAncientShips();

        uint256 pos = Random.randrange(0, _ids.length);
        uint256 _id = _ids[pos];

        return Types.SatInfo({id: _id, amount: 1});
    }
}
