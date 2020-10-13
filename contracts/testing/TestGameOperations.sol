pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {GameOperations} from '../GameOperations.sol';
import {Types} from '../lib/Types.sol';

/* solium-disable-next-line */
contract TestGameOperations is GameOperations {
    // create test functions

    function testAiFleetAttack(Types.SystemType starSystem) public {
        (uint256 a_offense, uint256 a_defense) = GS.getAiFleetInfo(starSystem);
        (uint256 d_offense, uint256 d_defense) = GS.getMasterFleetInfo(msg.sender);
        emit BattleStarted(msg.sender, a_offense, a_defense, address(this), d_offense, d_defense);

        bool result = battle(a_offense, a_defense, d_offense, d_defense, true, 10);
    }

    function testFhrDiscovery(
        uint256 rand,
        Types.Position memory star,
        Types.SystemType starSystem
    ) public {
        (uint256 low, uint256 high) = GS.getStarSystemYieldRange(starSystem);
        uint256 yield = randomrange(low, high, rand);
        GS.setStarSystemYield(star, yield);
        TS.mintFhr(msg.sender, GS.incrementTotalFhr());
    }

    function testSatDiscovery(
        uint256 rand,
        uint256[] memory ships,
        uint256[] memory amounts
    ) public {
        TS.sendSats(msg.sender, ships, amounts);
        updateMasterFleet(msg.sender, ships, amounts);
    }

    function testUpdateMasterFleet(
        address master,
        uint256[] memory ids,
        uint256[] memory amounts
    ) public {
        updateMasterFleet(master, ids, amounts);
    }
}
