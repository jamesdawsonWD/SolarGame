import { PlanetManagerC } from '../_utils/artifacts';
export async function createPlanet(signedCall, from) {
    const PlanetManager = await PlanetManagerC.deployed();
    return await PlanetManager.createPlanet(signedCall, { from });
}
export async function getPlanetImplementation(from) {
    const PlanetManager = await PlanetManagerC.deployed();
    return await PlanetManager.planetImplementation({ from });
}
