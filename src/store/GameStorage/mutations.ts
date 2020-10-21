import { StarPosition, GameStorageOperations, StarInfo } from './../types';
import { MutationTree } from 'vuex';
interface StarPositionTypePayload {
    pos: StarPosition;
    type: number;
}
export const mutations: MutationTree<GameStorageOperations> = {
    SET_CURRENT_STAR_POSITION: (state: GameStorageOperations, payload: StarPosition) =>
        (state.currentStarLocation = payload),
    SET_STAR_POSITION_TYPE: (state: GameStorageOperations, payload: StarPositionTypePayload) => {
        const uid = `${payload.pos.quadrant}${payload.pos.sector}${payload.pos.district}${payload.pos.star}`;
        const empty: { [key: string]: StarInfo } = {};
        empty[uid] = { systemType: payload.type };
        state.starsInfo = { ...state.starsInfo, ...empty };
    },
    SET_ALL_SAT_INFO: (state: GameStorageOperations, payload: any) => console.log(payload),
    SET_BOUNDARIES: (state: GameStorageOperations, payload: StarPosition) =>
        (state.boundaries = payload)
};
