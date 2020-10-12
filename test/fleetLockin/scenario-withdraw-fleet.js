import { SHIP_INFO } from '../lib/testValues';
import { withdrawMasterFleet } from '../_helpers/gameOperations';
import { getMasterFleetInfo } from '../_helpers/gameStorage';
import { lockin } from './scenario-lockin-fleet.js';
import BN from 'bignumber.js';
export async function withdraw(account, ids, amounts) {
    // lock in the accounts

    const infoBefore = await getMasterFleetInfo(account);

    const offense = ids.reduce(
        (acc, id, currentIndex) => acc + SHIP_INFO[id].offense * amounts[currentIndex],
        0
    );
    const defense = ids.reduce(
        (acc, id, currentIndex) => acc + SHIP_INFO[id].defense * amounts[currentIndex],
        0
    );

    await withdrawMasterFleet(ids, amounts, account);

    const infoAfter = await getMasterFleetInfo(account);

    assert.ok(
        new BN(infoAfter.offense).isEqualTo(new BN(infoBefore.offense).minus(new BN(offense)))
    );
    assert.ok(
        new BN(infoAfter.defense).isEqualTo(new BN(infoBefore.defense).minus(new BN(defense)))
    );
}
