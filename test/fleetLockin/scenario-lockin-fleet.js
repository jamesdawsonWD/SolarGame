import { WEAK_FLEET, SHIP_INFO } from '../lib/testValues';
import { lockinMasterFleet } from '../_helpers/gameOperations';
import { getMasterFleetInfo } from '../_helpers/gameStorage';
export async function lockin(account, ids, amounts) {
    await lockinMasterFleet(ids, amounts, account);

    const offense = ids.reduce(
        (acc, id, currentIndex) => acc + SHIP_INFO[id].offense * amounts[currentIndex],
        0
    );
    const defense = ids.reduce(
        (acc, id, currentIndex) => acc + SHIP_INFO[id].defense * amounts[currentIndex],
        0
    );

    const info = await getMasterFleetInfo(account);

    assert.equal(info.offense.toString(), offense.toString());
    assert.equal(info.defense.toString(), defense.toString());
}
