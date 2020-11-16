import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import {
    getSolarAddress,
    getSatAddress,
    getPlanetsAddress,
    getTreasuryAddress,
    getTraverseAddress,
    getPlanetManagerAddress,
    getGameEventsAddress,
    getBoundaries,
    getStartPosition,
    setProxyAddressToTokenId,
    getProxyAddressToTokenId,
    setTokenIdToProxyAddress,
    getTokenIdToProxyAddress,
    setTotalPlanets,
    getTotalPlanets,
    setTokenIdToYield,
    getTokenIdToYield,
    setMasterFleetPosition,
    getMasterFleetPosition,
    setGameEventIdToAddress,
    getGameEventIdToAddress,
    setUserAddressToGameEvent,
    getUserAddressToGameEvent,
    setTotalGameEvents,
    getTotalGameEvents
} from '../_helpers/gameStorage';
import { satAddress } from '../_helpers/sat';
import { solarAddress } from '../_helpers/solar';
import { planetTokenAddress } from '../_helpers/planetToken';
import { traverseAddress } from '../_helpers/traverse';
import { treasuryAddress } from '../_helpers/treasury';
import { planetManagerAddress } from '../_helpers/planetManager';
import { gameEventsAddress } from '../_helpers/gameEvents';
import { TEST_ADDRESS, BOUNDARIES, START_POSITION } from '../lib/testValues';
import truffleAssert from 'truffle-assertions';
export default function() {
    contract('Game Operations Unit Testing', async accounts => {
        // Accounts
        const [Owner, UserA, UserB, UserC, UserD] = accounts;

        // State snapshotting
        let snapshotId;
        beforeEach(async () => {
            snapshotId = await takeSnapshot(web3);
        });
        afterEach(async () => {
            await revertSnapshot(web3, snapshotId);
        });

        // Setup
        before(async () => {});

        // Addresses
        it('should get the correct sat address', async () => {
            const address = await getSatAddress(Owner);
            const acctualAddress = await satAddress();
            assert.equal(address, acctualAddress);
        });
        it('should get the correct solar address', async () => {
            const address = await getSolarAddress(Owner);
            const acctualAddress = await solarAddress();
            assert.equal(address, acctualAddress);
        });
        it('should get the correct PlanetManager address', async () => {
            const address = await getPlanetManagerAddress(Owner);
            const acctualAddress = await planetManagerAddress();
            assert.equal(address, acctualAddress);
        });

        it('should get the correct PlanetToken address', async () => {
            const address = await getPlanetsAddress(Owner);
            const acctualAddress = await planetTokenAddress();
            assert.equal(address, acctualAddress);
        });
        it('should get the correct Traverse address', async () => {
            const address = await getTraverseAddress(Owner);
            const acctualAddress = await traverseAddress();
            assert.equal(address, acctualAddress);
        });
        it('should get the correct Treasury address', async () => {
            const address = await getTreasuryAddress(Owner);
            const acctualAddress = await treasuryAddress();
            assert.equal(address, acctualAddress);
        });
        it('should get the correct GameEvents address', async () => {
            const address = await getGameEventsAddress(Owner);
            const acctualAddress = await gameEventsAddress();
            assert.equal(address, acctualAddress);
        });

        // Constants
        it('should get the start position constant', async () => {
            const startPos = await getStartPosition(Owner);
            assert.equal(startPos.toString(), START_POSITION);
        });

        it('should get the boundaries constant', async () => {
            const boundaries = await getBoundaries(Owner);
            assert.equal(boundaries.toString(), BOUNDARIES);
        });

        // Getters & Setters
        it('should set & get the proxyAddressToTokenId mapping', async () => {
            const id = 1;
            await setProxyAddressToTokenId(id, TEST_ADDRESS, Owner);
            const result = await getProxyAddressToTokenId(TEST_ADDRESS, Owner);
            assert.equal(result.toString(), id);
        });
        it('should set & get the tokenIdToProxyAddress mapping', async () => {
            const id = 1;
            await setTokenIdToProxyAddress(id, TEST_ADDRESS, Owner);
            const result = await getTokenIdToProxyAddress(id, Owner);
            assert.equal(result.toString(), TEST_ADDRESS);
        });
        it('should set & get the totalPlanets', async () => {
            const total = 10;
            await setTotalPlanets(total, Owner);
            const result = await getTotalPlanets(Owner);
            assert.equal(result.toString(), total);
        });
        it('should set & get the tokenIdToYield mapping', async () => {
            const id = 1;
            const tokenYield = 100;
            await setTokenIdToYield(id, tokenYield, Owner);
            const result = await getTokenIdToYield(id, Owner);
            assert.equal(result.toString(), tokenYield);
        });
        it('should set & get the master fleet position', async () => {
            const pos = [2, 1, 4, 872];
            await setMasterFleetPosition(pos, Owner);
            const result = await getMasterFleetPosition(Owner);
            assert.equal(result.toString(), pos);
        });
        it('should set & get the master fleet position', async () => {
            const pos = [2, 1, 4, 872];
            await setMasterFleetPosition(pos, Owner);
            const result = await getMasterFleetPosition(Owner);
            assert.equal(result.toString(), pos);
        });
        it('should set & get the gameEventIdToAddress mapping', async () => {
            const id = 1;
            await setGameEventIdToAddress(id, TEST_ADDRESS, Owner);
            const result = await getGameEventIdToAddress(id, Owner);
            assert.equal(result.toString(), TEST_ADDRESS);
        });
        it('should set & get the userAddressToGameEvent mapping', async () => {
            const id = 1;
            await setUserAddressToGameEvent(id, Owner);
            const result = await getUserAddressToGameEvent(Owner);
            assert.equal(result.toString(), id);
        });
        it('should set & get the Total Events', async () => {
            const amount = 10;
            await setTotalGameEvents(amount, Owner);
            const result = await getTotalGameEvents(Owner);
            assert.equal(result.toString(), amount);
        });
    });
}
