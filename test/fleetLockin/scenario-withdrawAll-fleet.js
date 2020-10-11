import { WEAK_FLEET } from '../lib/testValues';
import { withdrawMasterFleet } from '../_helpers/gameOperations';
import { getMasterFleetInfo } from '../_helpers/gameStorage';
import { lockin } from './scenario-lockin-fleet.js';
export async function withdrawAll(accounts) {
    const [Owner, UserA, UserB, UserC] = accounts;

    const ids = Object.keys(WEAK_FLEET);
    const amounts = Object.values(WEAK_FLEET);

    // lock in the accounts
    await lockin(accounts);

    await withdrawMasterFleet(ids, amounts, UserA);

    const info = await getMasterFleetInfo(UserA);

    assert.equal(info.offense.toString(), 0);
    assert.equal(info.defense.toString(), 0);

    // balance is returning undefined - dont know why
    // const one = await balanceOf(treasury, ids[0], UserA);
    // const balances = await balanceOfBatch(userAccounts, ids, UserA);
}
