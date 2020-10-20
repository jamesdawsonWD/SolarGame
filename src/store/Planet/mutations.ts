import { MutationTree } from 'vuex';
import { Planets } from './../types';

export const mutations: MutationTree<Planets> = {
    ADD_PLANET_BALANCE: (state: Planets, payload: { planet: string, amount: number }) => {
        (state[payload.planet].balance += payload.amount);
    },
    SUB_PLANET_BALANCE: (state: Planets, payload: { planet: string, amount: number }) => {
        (state[payload.planet].balance -= payload.amount);
    },
    ADD_PLANET_SATS: (state: Planets, payload: { planet: string, ids: number[], amounts: number[] }) => {
        for (let i = 0; i < payload.ids.length; i++) {
            (state[payload.planet].sats[i].balance += payload.amounts[i]);
        }
    },
    SUB_PLANET_SATS: (state: Planets, payload: { planet: string, ids: number[], amounts: number[] }) => {
        for (let i = 0; i < payload.ids.length; i++) {
            (state[payload.planet].sats[i].balance =
                state[payload.planet].sats[i].balance - payload.amounts[i] > 0
                    ? state[payload.planet].sats[i].balance
                    : 0
            );
        }
    },
    SET_PLANET_SAT_BALANCES: (state: Planets, payload: { planet: string, balances: number[] }) => {
        for (let i = 0; i < payload.balances.length; i++) {
            state[payload.planet].sats[i].id = i;
            state[payload.planet].sats[i].balance = payload.balances[i];
        }
    },
    SET_PLANET_DATELOCKED: (state: Planets, payload: { planet: string, dateLocked: Date }) => {
        state[payload.planet].dateLocked = payload.dateLocked;
    },
    SET_PLANET_TOKENID: (state: Planets, payload: { planet: string, tokenId: number }) => {
        state[payload.planet].tokenId = payload.tokenId;
    },
    SET_PLANET_YIELD: (state: Planets, payload: { planet: string, yield: number }) => {
        state[payload.planet].yield = payload.yield;
    },
    SET_PLANET_MINHOLD: (state: Planets, payload: { planet: string, minHold: number }) => {
        state[payload.planet].minHold = payload.minHold;
    }

};
