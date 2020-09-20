import { Module } from 'vuex';
import { RootState, UserInterfaceManager } from '../types';

export const state: UserInterfaceManager = {
    isLoading: false,
    modal: {
        show: false,
        content: '',
        data: {}
    }
};

import { getters } from './getters';
import { actions } from './actions';
import { mutations } from './mutations';

const namespaced = false;

export const userInterfaceManager: Module<UserInterfaceManager, RootState> = {
    namespaced,
    state,
    getters,
    mutations,
    actions
};
