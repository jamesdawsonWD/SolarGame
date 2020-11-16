import { TraverseC } from '../_utils/artifacts';

export async function traverseAddress() {
    const Traverse = await TraverseC.deployed();
    return Traverse.address;
}
export async function move(to, from) {
    const Traverse = await TraverseC.deployed();
    return await Traverse.move(to, { from });
}
