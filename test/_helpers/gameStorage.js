import { GameStorageC } from '../_utils/artifacts';

export async function getSolarAccess(address, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSolarAccess(address, { from });
}
export async function getSolarAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSolarAddress({ from });
}
export async function getSatAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getSatAddress({ from });
}
export async function getFhrAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getFhrAddress({ from });
}
export async function getTreasuryAddress(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getTreasuryAddress({ from });
}
export async function getDateStakeLocked(account, tokenId, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getDateStakeLocked(account, tokenId, { from });
}
export async function setDateStakeLocked(account, tokenId, locked, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.setDateStakeLocked(account, tokenId, locked, { from });
}
export async function getStakedBalance(account, tokenId, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getStakedBalance(account, tokenId, { from });
}
export async function setStakedBalance(account, tokenId, balance, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.setStakedBalance(account, tokenId, balance, { from });
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
export async function getStarSystemYield(id, from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getStarSystemYield(id, { from });
}
export async function setStarSystemYield(id, systemYield, from) {
    const GameStorage = await GameStorageC.deployed();
    await GameStorage.setStarSystemYield(id, systemYield, { from });
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
export async function getMasterAddressToShipIds(from) {
    const GameStorage = await GameStorageC.deployed();
    return await GameStorage.getMasterAddressToShipIds(from, { from });
}
