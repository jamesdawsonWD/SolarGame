import { TestFhrC } from '../_utils/artifacts';

export async function fhrAddress() {
    const Fhr = await TestFhrC.deployed();
    return Fhr.address;
}
