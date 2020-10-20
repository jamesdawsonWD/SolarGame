import { StarPosition, GameStorage } from './../types';
import { MutationTree } from 'vuex';

interface StarPositionTypePayload {
    pos: StarPosition;
    type: number;
}
export const mutations: MutationTree<GameStorage> = {
    SET_CURRENT_STAR_POSITION: (state: GameStorage, payload: StarPosition) =>
        (state.currentStarLocation = payload),
    SET_STAR_POSITION_TYPE: (state: GameStorage, payload: StarPositionTypePayload) =>
        (state.starsInfo[`${payload.pos.quadrant}${payload.pos.sector}${payload.pos.district}${payload.pos.star}`]
            .systemType = payload.type),
    SET_ALL_SAT_INFO: (state: GameStorage, payload: any) => console.log(payload),

};
