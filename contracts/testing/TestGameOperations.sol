pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {GameOperations} from '../GameOperations.sol';
import {Types} from '../lib/Types.sol';

/* solium-disable-next-line */
contract TestGameOperations is GameOperations {
    // create test functions
    event TestAddress(address a, address b, address c, address d);
    event TestUint(uint256 a, uint256 b);

    function testAiFleetAttack(Types.SystemType starSystem) public {
        (uint256 a_offense, uint256 a_defense) = GS.getAiFleetInfo(starSystem);
        (
            uint256 d_offense,
            uint256 d_defense,
            uint256[] memory d_balances,
            uint256[] memory d_ids
        ) = calculateStats(msg.sender);
        emit BattleStarted(msg.sender, a_offense, a_defense, address(this), d_offense, d_defense);

        bool result = battle(a_offense, a_defense, d_offense, d_defense, true, 10);
    }

    function testFhrDiscovery(Types.SystemType systemType) public {
        (uint256 low, uint256 high) = GS.getStarSystemYieldRange(systemType);
        uint256 _id = GS.incrementTotalFhr();
        GS.setTokenIdToYield(_id, randomrange(low, high));
        TS.mintFhr(msg.sender, _id);
    }

    function testSatDiscovery(
        uint256 rand,
        uint256[] memory ships,
        uint256[] memory amounts
    ) public {
        TS.sendSats(msg.sender, ships, amounts);
        // updateMasterFleet(msg.sender, ships, amounts);
    }

    function testUpdateMasterFleet(
        address master,
        uint256[] memory ids,
        uint256[] memory amounts
    ) public {
        // updateMasterFleet(master, ids, amounts);
    }
}
