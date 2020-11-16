import { GameOperationsC } from '../_utils/artifacts';

export async function gameOperationsAddress() {
    const GameOperations = await GameOperationsC.deployed();
    return GameOperations.address;
}

export async function userMove(pos, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.move(pos, { from });
}

export async function lockinMasterFleet(ids, amounts, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.lockInMasterFleet(ids, amounts, {
        from
    });
}

export async function attack(defender, turns, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.attack(defender, turns, {
        from
    });
}

export async function withdrawMasterFleet(ids, amounts, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.withdrawMasterFleet(ids, amounts, {
        from
    });
}

export async function stakeSolarToPlanet(amount, tokenId, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.stakeSolarToPlanet(amount, tokenId, {
        from
    });
}
export async function withdrawSolarFromPlanet(amount, tokenId, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.withdrawSolarFromPlanet(amount, tokenId, {
        from
    });
}

export async function testFhrDiscovery(systemType, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.testFhrDiscovery(systemType, {
        from
    });
}

export async function deployPlanet(tokenId, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.deployPlanet(tokenId, {
        from
    });
}
