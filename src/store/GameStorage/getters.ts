import { RootState, GameStorageOperations, StarPosition } from '../types';
import { GetterTree } from 'vuex';

export const getters: GetterTree<GameStorageOperations, RootState> = {
    GS_getCurrentPosition: state => state.currentStarLocation,
    GS_getStarPositionType: state => (pos: StarPosition) =>
        state.starsInfo[`${pos.quadrant}${pos.sector}${pos.district}${pos.star}`].systemType,
    GS_getBoundaries: state => state.boundaries
};
