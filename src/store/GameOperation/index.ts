import { Module } from 'vuex';
import { RootState, GameOperations } from '../types';

export const state: GameOperations = {

};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const gameOperations: Module<GameOperations, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
