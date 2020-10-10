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

export async function withdrawMasterFleet(ids, amounts, from) {
    const GameOperations = await GameOperationsC.deployed();
    await GameOperations.withdrawMasterFleet(ids, amounts, {
        from
    });
}
