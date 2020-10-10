import { GameStorageC } from '../_utils/artifacts';

export async function getSolarAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSolarAddress({ from });
}
export async function getSatAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSatAddress({ from });
}
export async function getFhrAdress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getFhrAdress({ from });
}
export async function getTreasuryAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTreasuryAddress({ from });
}
export async function getUserBalance(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getUserBalance(from, { from });
}
export async function getStartPosition(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getStartPosition({ from });
}
export async function getBoundaries(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getBoundaries({ from });
}
export async function incrementTotalFhr(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.incrementTotalFhr({ from });
}
export async function getStarSystemType(pos, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getStarSystemType(pos, { from });
}
export async function setStarSystemType(pos, type, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setStarSystemType(pos, type, { from });
}
export async function getStarSystemYield(pos, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getStarSystemYield(pos, { from });
}
export async function setStarSystemYield(pos, systemYield, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setStarSystemYield(pos, systemYield, { from });
}
export async function getMasterFleetPosition(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getMasterFleetPosition(from, { from });
}
export async function setMasterFleetPosition(pos, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setMasterFleetPosition(from, pos, { from });
}
export async function getSatInfo(id, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSatInfo(id, { from });
}
export async function getMasterFleetOffense(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getMasterFleetOffense(from, { from });
}
export async function setMasterFleetOffense(offense, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setMasterFleetOffense(from, offense, { from });
}
export async function getMasterFleetDefense(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getMasterFleetDefense(from, { from });
}
export async function setMasterFleetDefense(defense, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setMasterFleetDefense(from, defense, { from });
}
export async function getMasterLockedInShipInfo(id, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getMasterLockedInShipInfo(from, id, { from });
}
export async function setMasterLockedInShipInfo(id, amount, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setMasterFleetDefense(from, id, amount, { from });
}
export async function getMasterFleetInfo(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getMasterFleetInfo(from, { from });
}
