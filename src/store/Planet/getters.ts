import { GetterTree } from 'vuex';
import { RootState, Planets } from '../types';

export const getters: GetterTree<Planets, RootState> = {
    PLANET_getBalance: state => (planet: string) => state[planet].balance,
    PLANET_getYield: (state) => (planet: string) => state[planet].yield,
    PLANET_getSats: state => (planet: string) => state[planet].sats,
    PLANET_getDateLocked: state => (planet: string) => state[planet].dateLocked,
    PLANET_getMinHold: state => (planet: string) => state[planet].minHold,
};
