import { Module } from 'vuex';
import { RootState, GameStorage } from './../types';

export const state: GameStorage = {
    currentStarLocation: null,
    satsInfo: {},
    planetsToTokenId: {},
    tokenIdToPlanet: {},
    starsInfo: {},
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const gameStorage: Module<GameStorage, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
