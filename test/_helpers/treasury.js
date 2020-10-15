import { TreasuryC } from '../_utils/artifacts';

export async function treasuryAddress() {
    const Treasury = await TreasuryC.deployed();
    return Treasury.address;
}

export async function sendSats(to, ids, amounts, from) {
    const Treasury = await TreasuryC.deployed();
    await Treasury.sendSats(to, ids, amounts, { from });
}
export async function recieveSats(from, ids, amounts) {
    const Treasury = await TreasuryC.deployed();
    await Treasury.recieveSats(from, ids, amounts, { from });
}

export async function mintFhr(to, tokenId, from) {
    const Treasury = await TreasuryC.deployed();
    await Treasury.mintFhr(to, tokenId, {
        from
    });
}

export async function mintSolar(to, amount, from) {
    const Treasury = await TreasuryC.deployed();
    await Treasury.mintSolar(to, amount, {
        from
    });
}
