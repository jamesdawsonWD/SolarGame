import { GameStorageC } from '../_utils/artifacts';

/**************** Addresses ***********************/
export async function getSolarAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSolarAddress({ from });
}
export async function getPlanetManagerAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getPlanetManagerAddress({ from });
}
export async function getSatAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSatAddress({ from });
}
export async function getPlanetsAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getPlanetsAddress({ from });
}
export async function getTreasuryAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTreasuryAddress({ from });
}

export async function getGameEventsAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getGameEventsAddress({ from });
}
export async function getTraverseAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTraverseAddress({ from });
}
/**************** Planet Manager ***********************/

export async function getProxyAddressToTokenId(address, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getProxyAddressToTokenId(address, { from });
}
export async function setProxyAddressToTokenId(tokenId, address, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.setProxyAddressToTokenId(tokenId, address, { from });
}
export async function getTokenIdToProxyAddress(tokenId, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTokenIdToProxyAddress(tokenId, { from });
}
export async function setTokenIdToProxyAddress(tokenId, address, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.setTokenIdToProxyAddress(tokenId, address, { from });
}
export async function getTotalPlanets(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTotalPlanets({ from });
}
export async function setTotalPlanets(total, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.setTotalPlanets(total, { from });
}
export async function getTokenIdToYield(tokenId, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTokenIdToYield(tokenId, { from });
}
export async function setTokenIdToYield(tokenId, tokenYield, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setTokenIdToYield(tokenId, tokenYield, { from });
}
/***************** Traverse ***********************/

export async function getStartPosition(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getStartPosition({ from });
}
export async function getBoundaries(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getBoundaries({ from });
}
export async function getMasterFleetPosition(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getMasterFleetPosition(from, { from });
}
export async function setMasterFleetPosition(pos, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setMasterFleetPosition(from, pos, { from });
}
/***************** Game Events ***********************/

export async function getUserAddressToGameEvent(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getUserAddressToGameEvent(from, { from });
}
export async function setUserAddressToGameEvent(gameEvent, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setUserAddressToGameEvent(from, gameEvent, { from });
}
export async function getGameEventIdToAddress(gameEvent, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getGameEventIdToAddress(gameEvent, { from });
}
export async function setGameEventIdToAddress(gameEvent, address, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setGameEventIdToAddress(gameEvent, address, { from });
}
export async function getTotalGameEvents(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTotalGameEvents({ from });
}
export async function setTotalGameEvents(amount, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setTotalGameEvents(amount, { from });
}
/***************** Battle ***********************/

export async function getSatInfo(id, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSatInfo(id, { from });
}
