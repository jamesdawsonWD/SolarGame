import { MutationTree } from 'vuex';
import { Planets } from './../types';

export const mutations: MutationTree<Planets> = {
    // ADD_PLANET_BALANCE: (state: Planets, payload: { planet: string; amount: number }) => {
    //     state[payload.planet].balance += payload.amount;
    // },
    // SUB_PLANET_BALANCE: (state: Planets, payload: { planet: string; amount: number }) => {
    //     state[payload.planet].balance -= payload.amount;
    // },
    // ADD_PLANET_SATS: (state: Planets, payload: { planet: string; ids: number[]; amounts: number[] }) => {
    //     for (let i = 0; i < payload.ids.length; i++) {
    //         state[payload.planet].sats[i].balance += payload.amounts[i];
    //     }
    // },
    // SUB_PLANET_SATS: (state: Planets, payload: { planet: string; ids: number[]; amounts: number[] }) => {
    //     for (let i = 0; i < payload.ids.length; i++) {
    //         state[payload.planet].sats[i].balance =
    //             state[payload.planet].sats[i].balance - payload.amounts[i] > 0
    //                 ? state[payload.planet].sats[i].balance
    //                 : 0;
    //     }
    // },

    SET_PLANET_DATELOCKED: (state: Planets, payload: { planet: string; dateLocked: Date }) => {
        const planet = {
            [payload.planet]: {
                ...state.planets[payload.planet],
                dateLocked: payload.dateLocked
            }
        };
        state.planets = { ...state.planets, ...planet };
    },
    SET_PLANET_TOKENID: (state: Planets, payload: { planet: string; tokenId: number }) => {
        state.planets[payload.planet].tokenId = payload.tokenId;
    },

    SET_PLANET_YIELD: async (state: Planets, payload: { planet: string; planetYield: number }) => {
        const planet = {
            [payload.planet]: {
                ...state.planets[payload.planet],
                planetYield: payload.planetYield
            }
        };
        state.planets = { ...state.planets, ...planet };
    },
    SET_STAKED: (state: Planets, payload: { planet: string; staked: number }) => {
        const planet = {
            [payload.planet]: {
                ...state.planets[payload.planet],
                balance: payload.staked
            }
        };
        state.planets = { ...state.planets, ...planet };
    },
    SET_PLANET_MINHOLD: (state: Planets, payload: { planet: string; minHold: number }) => {
        const planet = {
            [payload.planet]: {
                ...state.planets[payload.planet],
                minHold: payload.minHold
            }
        };
        state.planets = { ...state.planets, ...planet };
    },
    SET_TOKEN_ID_TO_PROXY: (state: Planets, payload: { planet: string; tokenId: number }) => {
        state.tokenIdToProxy = { ...state.tokenIdToProxy, ...{ [payload.tokenId]: payload.planet } };
    }
};
