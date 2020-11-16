import { GetterTree } from 'vuex';
import { RootState, Planets } from '../types';

export const getters: GetterTree<Planets, RootState> = {
    PLANET_getBalance: state => (payload: { planet: string }) => state.planets[payload.planet].balance,
    PLANET_getYield: state => (payload: { planet: string }) => {
        return state.planets[payload.planet] ? state.planets[payload.planet].planetYield : 0;
    },
    PLANET_getSats: state => (payload: { planet: string }) => state.planets[payload.planet].sats,
    PLANET_getDateLocked: state => (payload: { planet: string }) => state.planets[payload.planet].dateLocked,
    PLANET_getMinHold: state => (payload: { planet: string }) => state.planets[payload.planet].minHold,
    PLANET_getInfo: state => (payload: { planet: string }) => {
        return state.planets[payload.planet];
    },
    PLANET_getTokenIdToProxy: state => (payload: { tokenId: number }) => {
        state.tokenIdToProxy[payload.tokenId];
    }
};
