import { RootState, GameStorage, StarPosition } from '../types';
import { GetterTree } from 'vuex';

export const getters: GetterTree<GameStorage, RootState> = {
    GS_getCurrentPosition: state => state.currentStarLocation,
    GS_getStarPositionType: (state, pos: StarPosition) => state.starsInfo[`${pos.quadrant}${pos.sector}${pos.district}${pos.star}`]
        .systemType
};
