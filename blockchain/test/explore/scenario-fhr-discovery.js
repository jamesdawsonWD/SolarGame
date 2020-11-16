import { ADDRESS_ZERO, SYSTEM_TYPES, YIELDS } from '../lib/testValues';
import { testFhrDiscovery } from '../_helpers/gameOperations';
import { getTokenAddress } from '../_helpers/gameStorage';
import { tokenOfOwnerByIndex } from '../_helpers/planetToken';
import { getYield } from '../_helpers/planet';
export async function fhrDiscovery(account, systemType, amounts) {
    await testFhrDiscovery(systemType, account);
    const planetToken = await tokenOfOwnerByIndex(account, 0, account);

    // const planetProxy = await getTokenAddress(planetToken, account);
    // assert.ok(planetProxy != ADDRESS_ZERO);

    // const planetYield = await getYield(planetProxy, account);

    // let low;
    // let high;

    // switch (systemType) {
    //     case SYSTEM_TYPES.HighYieldSystem:
    //         low = YIELDS.HighYieldSystem.low;
    //         high = YIELDS.HighYieldSystem.high;
    //         break;
    //     case SYSTEM_TYPES.LowYieldSystem:
    //         low = YIELDS.LowYieldSystem.low;
    //         high = YIELDS.LowYieldSystem.high;
    //         break;
    //     case SYSTEM_TYPES.MediumYieldSystem:
    //         low = YIELDS.MediumYieldSystem.low;
    //         high = YIELDS.MediumYieldSystem.high;
    //         break;
    //     case SYSTEM_TYPES.InsaneYieldSystem:
    //         low = YIELDS.InsaneYieldSystem.low;
    //         high = YIELDS.InsaneYieldSystem.high;
    //         break;
    // }
    // assert.ok(planetYield >= low && planetYield <= high);

    // return planetProxy;
}
