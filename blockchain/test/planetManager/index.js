import { takeSnapshot, revertSnapshot } from '../_utils/evm';
import { mintFhr } from '../_helpers/planetToken';
import { SYSTEM_TYPES } from '../lib/testValues';
import { createPlanet, getPlanetImplementation } from '../_helpers/planetManager';
import { planetAddress, getYield } from '../_helpers/planet';
import { treasuryAddress } from '../_helpers/treasury';
import { fhrAddress } from '../_helpers/planetToken';
import { solarAddress } from '../_helpers/solar';
import { satAddress } from '../_helpers/sat';
import truffleAssert from 'truffle-assertions';
export default function() {
    contract('PlanetManager', async accounts => {
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

        it('planet contract and planet implementation address should match ', async () => {
            const impl = await getPlanetImplementation(Owner);
            const planet = await planetAddress();
            assert.equal(impl, planet);
        });

        it('should create a planet', async () => {
            const treasury = await treasuryAddress();
            const solar = await solarAddress();
            const sat = await satAddress();
            const fhr = await fhrAddress();

            const signature = web3.eth.abi.encodeFunctionCall(
                {
                    name: 'initialize',
                    type: 'function',
                    inputs: [
                        {
                            type: 'address',
                            name: '_treasury'
                        },
                        {
                            type: 'address',
                            name: '_solar'
                        },
                        {
                            type: 'address',
                            name: '_fhr'
                        },
                        {
                            type: 'address',
                            name: '_sats'
                        },
                        {
                            type: 'uint256',
                            name: '_yield'
                        },
                        {
                            type: 'uint256',
                            name: '_tokenId'
                        }
                    ]
                },
                [treasury, solar, sat, fhr, 100, 1]
            );
            const receipt = await createPlanet(signature, Owner);

            const proxyAddress = receipt.logs[0].args.proxy;

            const proxyYield = await getYield(proxyAddress, Owner);

            // assert.equal(proxyYield.toString(), 100);
        });
    });
}
