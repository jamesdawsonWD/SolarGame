import { takeSnapshot, revertSnapshot, advanceTime } from '../_utils/evm';
import { SYSTEM_TYPES, SECONDS_IN_DAY, ALL_SHIPS } from '../lib/testValues';
import { createPlanet, getPlanetImplementation } from '../_helpers/planetManager';
import {
    planetAddress,
    depositSolar,
    withdrawSolar,
    depositSats,
    withdrawSats,
    getYield
} from '../_helpers/planet';
import { sendSats, mintSolar } from '../_helpers/treasury';
import { fhrDiscovery } from '../explore/scenario-fhr-discovery';
import { solarBalanceOf, solarApprove } from '../_helpers/solar';
import { satBalanceOfBatch, satApproveForAll } from '../_helpers/sat';
import { getTokenAddress } from '../_helpers/fhr';
import truffleAssert from 'truffle-assertions';
import BigNumber from 'bignumber.js';
export default function() {
    contract('Planet', async accounts => {
        // Accounts
        const [Owner, UserA, UserB, UserC, UserD] = accounts;
        const amount = new BigNumber(300000);
        const YEAR = SECONDS_IN_DAY * 365;
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
            await sendSats(Owner, Object.keys(ALL_SHIPS), Object.values(ALL_SHIPS), Owner);
            await satApproveForAll(planetProxy, true, Owner);
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

            const time = YEAR;

            await advanceTime(time);
            await withdrawSolar(planetProxy, amount, Owner);

            const planetYield = await getYield(planetProxy, Owner);
            const ownerBalanceAfter = await solarBalanceOf(Owner);

            const percentageOfYear = (time * 100) / YEAR;
            const reward = amount
                .multipliedBy(
                    new BigNumber(planetYield).multipliedBy(percentageOfYear).dividedBy(100)
                )
                .dividedBy(100);

            console.log(ownerBalanceBefore, ownerBalanceAfter);
            console.log(reward, amount);
            assert.ok(new BigNumber(ownerBalanceAfter).isEqualTo(reward.plus(amount)));
        });
        // it('should reward the planet if a second despoit is made and also reset the dateLocked', async () => {
        //     const impl = await getPlanetImplementation(Owner);
        //     const planet = await planetAddress();
        //     assert.equal(impl, planet);
        // });

        it('should deposit sats at the planet', async () => {
            const ids = [1, 3, 4, 35];
            const amounts = [5, 4, 2, 1];
            await depositSats(planetProxy, ids, amounts, Owner);

            const addresses = new Array(ids.length).fill(planetProxy);
            const balances = await satBalanceOfBatch(addresses, ids, Owner);
            for (let i = 0; i < balances.length; i++) {
                assert.equal(balances[i].toString(), amounts[i]);
            }
            //  assert.equal(impl, planet);
        });
        it('should withdraw sats from the planet', async () => {
            const ids = [1, 3, 4, 35];
            const amounts = [5, 4, 2, 1];
            const addresses = new Array(ids.length).fill(Owner);

            await depositSats(planetProxy, ids, amounts, Owner);
            const balancesBefore = await satBalanceOfBatch(addresses, ids, Owner);
            for (let i = 0; i < balancesBefore.length; i++) {
                assert.equal(
                    balancesBefore[i].toString(),
                    Object.values(ALL_SHIPS)[ids[i]] - amounts[i]
                );
            }
            await withdrawSats(planetProxy, ids, amounts, Owner);
            const balancesAfter = await satBalanceOfBatch(addresses, ids, Owner);
            for (let i = 0; i < balancesAfter.length; i++) {
                assert.equal(balancesAfter[i].toString(), Object.values(ALL_SHIPS)[ids[i]]);
            }
        });
    });
}
