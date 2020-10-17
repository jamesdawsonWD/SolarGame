import { takeSnapshot, revertSnapshot, advanceTime } from '../_utils/evm';
import { SYSTEM_TYPES, SECONDS_IN_DAY } from '../lib/testValues';
import { createPlanet, getPlanetImplementation } from '../_helpers/planetManager';
import {
    planetAddress,
    depositSolar,
    withdrawSolar,
    depositSats,
    withdrawSats,
    getYield
} from '../_helpers/planet';
import { mintSolar } from '../_helpers/treasury';
import { fhrDiscovery } from '../explore/scenario-fhr-discovery';
import { solarBalanceOf, solarApprove } from '../_helpers/solar';
import { satAddress } from '../_helpers/sat';
import { getTokenAddress } from '../_helpers/fhr';
import truffleAssert from 'truffle-assertions';
import BigNumber from 'bignumber.js';
export default function() {
    contract('Planet', async accounts => {
        // Accounts
        const [Owner, UserA, UserB, UserC, UserD] = accounts;
        const amount = new BigNumber(300000);

        // State snapshotting
        let snapshotId;
        beforeEach(async () => {
            snapshotId = await takeSnapshot(web3);
        });
        afterEach(async () => {
            await revertSnapshot(web3, snapshotId);
        });
        let planetProxy;
        // Setup
        before(async () => {
            // this should be replaced with planetManager create once we figure out
            // how to get it working
            planetProxy = await fhrDiscovery(Owner, SYSTEM_TYPES.HighYieldSystem);
            await mintSolar(Owner, amount, Owner);
            await solarApprove(planetProxy, amount, Owner);
        });

        it('should deposit solar into the planet', async () => {
            const balanceBefore = await solarBalanceOf(planetProxy);
            assert.equal(balanceBefore.toString(), 0);

            await depositSolar(planetProxy, amount, Owner);

            const balanceAfter = await solarBalanceOf(planetProxy);
            assert.equal(balanceAfter.toString(), amount);
        });
        it('should withdraw the solar with the reward after the minimum hold period', async () => {
            await depositSolar(planetProxy, amount, Owner);

            const ownerBalanceBefore = await solarBalanceOf(Owner);
            assert.equal(ownerBalanceBefore.toString(), 0);

            await advanceTime(SECONDS_IN_DAY * 365);
            await withdrawSolar(planetProxy, amount, Owner);

            const planetYield = await getYield(planetProxy, Owner);
            console.log(planetYield);
            const ownerBalanceAfter = await solarBalanceOf(Owner);
            assert.equal(ownerBalanceAfter.toString(), 0);
        });
        // it('should reward the planet if a second despoit is made and also reset the dateLocked', async () => {
        //     const impl = await getPlanetImplementation(Owner);
        //     const planet = await planetAddress();
        //     assert.equal(impl, planet);
        // });

        // it('should deposit sats at the planet', async () => {
        //     const impl = await getPlanetImplementation(Owner);
        //     const planet = await planetAddress();
        //     assert.equal(impl, planet);
        // });
        // it('should withdraw sats from the planet', async () => {
        //     const impl = await getPlanetImplementation(Owner);
        //     const planet = await planetAddress();
        //     assert.equal(impl, planet);
        // });
    });
}
