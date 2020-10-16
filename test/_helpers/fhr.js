import { FhrC } from '../_utils/artifacts';

export async function fhrAddress() {
    const Fhr = await FhrC.deployed();
    return Fhr.address;
}
export async function mintFhr(to, tokenId, from) {
    const Fhr = await FhrC.deployed();
    return await Fhr.mint(to, tokenId, { from });
}
export async function fhrOwnerOf(tokenId, from) {
    const Fhr = await FhrC.deployed();
    return await Fhr.ownerOf(tokenId, { from });
}
export async function fhrBalanceOf(address, from) {
    const Fhr = await FhrC.deployed();
    return await Fhr.balanceOf(address, { from });
}
export async function tokenOfOwnerByIndex(address, index, from) {
    const Fhr = await FhrC.deployed();
    return await Fhr.tokenOfOwnerByIndex(address, index, { from });
}
export async function fhrApproveAll(approver, approveBool, from) {
    const Fhr = await FhrC.deployed();
    await Fhr.setApprovalForAll(approver, approveBool, {
        from
    });
}
