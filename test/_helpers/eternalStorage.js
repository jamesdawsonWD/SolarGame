import { EternalStorageC } from '../_utils/artifacts';

export async function getBool(location, from) {
    const EternalStorage = await EternalStorageC.deployed();
    return await EternalStorage.getBool(location, { from });
}
