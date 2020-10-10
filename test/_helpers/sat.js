import { TestSatC } from '../_utils/artifacts';

export async function approveForAll(approver, approveBool, from) {
    const Sat = await TestSatC.deployed();
    await Sat.setApprovalForAll(approver, approveBool, {
        from
    });
}

export async function satAddress() {
    const Sat = await TestSatC.deployed();
    return Sat.address;
}
