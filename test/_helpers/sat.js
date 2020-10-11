import { TestSatC } from '../_utils/artifacts';

export async function satAddress() {
    const Sat = await TestSatC.deployed();
    return Sat.address;
}

export async function approveForAll(approver, approveBool, from) {
    const Sat = await TestSatC.deployed();
    await Sat.setApprovalForAll(approver, approveBool, {
        from
    });
}
export async function balanceOfBatch(accounts, ids, from) {
    const Sat = await TestSatC.deployed();
    await Sat.balanceOfBatch(accounts, ids, {
        from
    });
}
export async function balanceOf(account, id, from) {
    const Sat = await TestSatC.deployed();
    console.log(Sat);
    await Sat.balanceOf(account, id, {
        from
    });
}
