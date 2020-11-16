import { GameEventsC } from '../_utils/artifacts';

export async function gameEventsAddress() {
    const GameEvents = await GameEventsC.deployed();
    return GameEvents.address;
}
export async function generate(to, from) {
    const GameEvents = await GameEventsC.deployed();
    return await GameEvents.generate(to, { from });
}
export async function trigger(to, from) {
    const GameEvents = await GameEventsC.deployed();
    return await GameEvents.trigger(to, { from });
}
