import { PlanetTokenC } from '../_utils/artifacts';

export async function planetTokenAddress() {
    const PlanetToken = await PlanetTokenC.deployed();
    return PlanetToken.address;
}
export async function pintPlanetToken(to, tokenId, from) {
    const PlanetToken = await PlanetTokenC.deployed();
    return await PlanetToken.mint(to, tokenId, { from });
}
export async function planetTokenOwnerOf(tokenId, from) {
    const PlanetToken = await PlanetTokenC.deployed();
    return await PlanetToken.ownerOf(tokenId, { from });
}
export async function planetTokenBalanceOf(address, from) {
    const PlanetToken = await PlanetTokenC.deployed();
    return await PlanetToken.balanceOf(address, { from });
}
export async function pokenOfOwnerByIndex(address, index, from) {
    const PlanetToken = await PlanetTokenC.deployed();
    return await PlanetToken.tokenOfOwnerByIndex(address, index, { from });
}
export async function planetTokenApproveAll(approver, approveBool, from) {
    const PlanetToken = await PlanetTokenC.deployed();
    await PlanetToken.setApprovalForAll(approver, approveBool, {
        from
    });
}
