import { TestSolarC } from '../_utils/artifacts';

export async function solarAddress() {
    const Solar = await TestSolarC.deployed();
    return Solar.address;
}
