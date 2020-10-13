import { SHIP_INFO } from '../lib/testValues';
import { lockinMasterFleet } from '../_helpers/gameOperations';
import { makeShipArrayList, hasEqualValues } from '../_utils/base';
import { getMasterFleetInfo, getMasterAddressToShipIds } from '../_helpers/gameStorage';
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
    const storedIds = await getMasterAddressToShipIds(account);
    // const actualIds = makeShipArrayList(ids, Object.keys(SHIP_INFO).length);
    // console.log(actualIds);
    // console.log(storedIds);
    // assert.ok(hasEqualValues(storedIds, actualIds));
    assert.equal(info.offense.toString(), offense.toString());
    assert.equal(info.defense.toString(), defense.toString());
}
