import { PlanetC } from '../_utils/artifacts';
export async function planetAddress() {
    const Planet = await PlanetC.deployed();
    return Planet.address;
}
export async function getYield(planet, from) {
    const Planet = await PlanetC.at(planet);
    return await Planet.yield.call({ from });
}
export async function getDateLocked(planet, from) {
    const Planet = await PlanetC.at(planet);
    return await Planet.dateLocked.call({ from });
}
export async function getTokenId(planet, from) {
    const Planet = await PlanetC.at(planet);
    return await Planet.tokenId.call({ from });
}
export async function depositSolar(planet, amount, from) {
    const Planet = await PlanetC.at(planet);
    return await Planet.depositSolar(amount, { from });
}
export async function withdrawSolar(planet, amount, from) {
    const Planet = await PlanetC.at(planet);
    return await Planet.withdrawSolar(amount, { from });
}
export async function depositSats(planet, ids, amounts, from) {
    const Planet = await PlanetC.at(planet);
    return await Planet.depositSats(ids, amounts, { from });
}
export async function withdrawSats(planet, ids, amounts, from) {
    const Planet = await PlanetC.at(planet);
    return await Planet.withdrawSats(ids, amounts, { from });
}
