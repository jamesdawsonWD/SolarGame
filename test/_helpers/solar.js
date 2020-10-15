import { TestSolarC } from '../_utils/artifacts';

export async function solarAddress() {
    const Solar = await TestSolarC.deployed();
    return Solar.address;
}

export async function solarBalanceOf(account, from) {
    const Solar = await TestSolarC.deployed();
    return await Solar.balanceOf(account, { from });
}

export async function solarApprove(spender, amount, from) {
    const Solar = await TestSolarC.deployed();
    return await Solar.approve(spender, amount, { from });
}
