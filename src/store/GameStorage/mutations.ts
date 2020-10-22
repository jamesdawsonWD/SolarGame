import { StarPosition, GameStorageOperations, StarInfo, PlanetInfo } from './../types';
import { MutationTree } from 'vuex';
interface StarPositionTypePayload {
    pos: StarPosition;
    systemType: number;
}
export const mutations: MutationTree<GameStorageOperations> = {
    SET_CURRENT_STAR_POSITION: (state: GameStorageOperations, payload: StarPosition) =>
        (state.currentStarLocation = payload),
    SET_STAR_POSITION_TYPE: (state: GameStorageOperations, payload: StarPositionTypePayload) => {
        const uid = `${payload.pos.quadrant}${payload.pos.sector}${payload.pos.district}${payload.pos.star}`;
        const empty: { [key: string]: StarInfo } = {};
        empty[uid] = { systemType: payload.systemType };
        state.starsInfo = { ...state.starsInfo, ...empty };
    },
    SET_ALL_SAT_INFO: (state: GameStorageOperations, payload: any) => console.log(payload),

    GS_SET_PLANET_YIELD: (
        state: GameStorageOperations,
        payload: { tokenId: number; planetYield: number }
    ) => {
        const tokenToYield: { [key: number]: number } = {};
        tokenToYield[payload.tokenId] = payload.planetYield;
        state.tokenIdToYield = { ...state.tokenIdToYield, ...tokenToYield };
    }
};
