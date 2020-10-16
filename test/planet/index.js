import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { mintFhr } from '../_helpers/fhr';
import { SYSTEM_TYPES } from '../lib/testValues';
import { createPlanet, getPlanetImplementation } from '../_helpers/planetManager';
import {
    planetAddress,
    depositSolar,
    withdrawSolar,
    depositSats,
    withdrawSats
} from '../_helpers/planet';
import { treasuryAddress } from '../_helpers/treasury';
import { fhrAddress } from '../_helpers/fhr';
import { mintSolar, solarBalanceOf } from '../_helpers/solar';
import { satAddress } from '../_helpers/sat';
import truffleAssert from 'truffle-assertions';
export default function() {
    contract('PlanetManager', async accounts => {
        // Accounts
        const [Owner, UserA, UserB, UserC, UserD] = accounts;
        const amount = 1000000;

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
            await fhrDiscovery(Owner, SYSTEM_TYPES.MediumYieldSystem);
            planetProxy = await getTokenAddress(1, account);

            await mintSolar(UserA, amount, UserA);
        });

        it('should deposit solar into the planet', async () => {
            const balanceBefore = await solarBalanceOf(planetProxy);
            assert.equal(balanceBefore.toString(), 0);

            await depositSolar(amount, Owner);

            const balanceAfter = await solarBalanceOf(planetProxy);
            assert.equal(balanceAfter.toString(), amount);
        });
        // it('should withdraw the solar with the reward from the planet', async () => {
        //     const impl = await getPlanetImplementation(Owner);
        //     const planet = await planetAddress();
        //     assert.equal(impl, planet);
        // });
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
