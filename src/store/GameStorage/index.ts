import { Module } from 'vuex';
import { RootState, GameStorageOperations } from './../types';

export const state: GameStorageOperations = {
    currentStarLocation: null,
    satsInfo: {},
    planetsToTokenId: {},
    tokenIdToYield: {},
    starsInfo: {},
    boundaries: {
        quadrant: 0,
        sector: 0,
        district: 0,
        star: 0
    }
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const gameStorage: Module<GameStorageOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
