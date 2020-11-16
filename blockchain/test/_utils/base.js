export const makeShipArrayList = (ids, length) => {
    const empty = new Array(length).fill(false);
    for (let i = 0; i < ids.length; i++) {
        for (let j = 0; j < empty.length; j++) {
            empty[j] = empty[j] ? true : j == ids[i];
        }
    }
    return empty;
};

export const hasEqualValues = (a, b) => {
    if (a.length != b.length) return false;
    for (let i = 0; i < a.length; i++) {
        if (a[i] != b[i]) return false;
    }
    return true;
};
