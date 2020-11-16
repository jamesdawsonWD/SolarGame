// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import {Initializable} from '@openzeppelin/upgrades-core/contracts/Initializable.sol';
import {Types} from './lib/Types.sol';
import {GameStorage} from './GameStorage.sol';
import {GameEvents} from './GameEvents.sol';

/**
 * @title Operation
 * @author Big Beluga
 *
 * Primary public function for entering into the protocol
 */
contract Traverse is Initializable {
    GameStorage GS;
    GameEvents GE;

    // ============ Events ============
    event LogMove(uint8 quadrant, uint8 district, uint8 sector, uint256 star);

    /**
     *   Initialize - init function
     *   @param _gameStorage - the address of the games eternal storage
     */
    function initialize(address _gameStorage) public initializer {
        GS = GameStorage(_gameStorage);
        GE = GameEvents(GS.getGameEventsAddress());
    }

    /**
     *   Move - Moves a Star fleet to a new position.
     *   @param to - the location the user wishes to move their fleet to.
     */
    function move(Types.Position memory to) public {
        require(
            Types.positionWithinBoundaries(to, GS.getBoundaries()),
            'Position must be within set limits of the known universe'
        );

        // Get the fleets current position.
        Types.Position memory from = GS.getMasterFleetPosition(msg.sender);

        // If an addresses position is not on chain we have a new user.
        // We shall set the users from position to be the Generic start position
        // Events can not be triggered on a users first move into space
        if (Types.positionNotSet(from)) {
            from = GS.getStartPosition();
        } else {
            // Trigger Event
            GE.trigger(msg.sender);
        }

        require(!Types.positionIsEqual(to, from), 'You cannot move to your current location');

        // Create and store the next event in store for the user in a private mapping
        GS.setUserAddressToGameEvent(msg.sender, GE.generate());

        GS.setMasterFleetPosition(msg.sender, to);
        emit LogMove(to.quadrant, to.district, to.sector, to.star);
    }
}
