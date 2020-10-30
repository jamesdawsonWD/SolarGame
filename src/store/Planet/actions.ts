import { ActionTree, ActionContext } from 'vuex';
import { RootState, Planets } from './../types';
import { SHIP_INFO } from '@/utils';
export const actions: ActionTree<Planets, RootState> = {
    PLANET_depositSolar(
        context: ActionContext<Planets, RootState>,
        payload: { planet: string; amount: number }
    ) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .depositSolar(payload.amount)
            .send({ from: Address, gas: 4000000 })
            .then(() =>
                context.commit('SET_STAKED', {
                    staked: payload.amount,
                    planet: payload.planet
                })
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    withdrawSolar(context: ActionContext<Planets, RootState>, payload: { planet: string; amount: number }) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .withdrawSolar(payload.amount)
            .send({ from: Address })
            .then(() =>
                context.commit('SUB_PLANET_BALANCE', {
                    planet: payload.planet,
                    amount: payload.amount
                })
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    PLANET_depositSats(
        context: ActionContext<Planets, RootState>,
        payload: { planet: string; ids: number[]; amounts: number[] }
    ) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .depositSats(payload.ids, payload.amounts)
            .send({ from: Address, gasPrice: 30000000 })
            .then(() =>
                context.commit('ADD_PLANET_SATS', {
                    planet: payload.planet,
                    ids: payload.ids,
                    amounts: payload.amounts
                })
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    withdrawSats(
        context: ActionContext<Planets, RootState>,
        payload: { planet: string; ids: number[]; amounts: number[] }
    ) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .withdrawSats(payload.ids, payload.amounts)
            .send({ from: Address })
            .then(() =>
                context.commit('SUB_PLANET_SATS', {
                    planet: payload.planet,
                    ids: payload.ids,
                    amounts: payload.amounts
                })
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    async PLANET_retrievePlanetYield(
        context: ActionContext<Planets, RootState>,
        payload: { planet: string }
    ) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .yield()
            .call({ from: Address })
            .then((planetYield: number) => {
                context.commit('SET_PLANET_YIELD', { planet: payload.planet, planetYield });
            })
            .catch((err: Error) => {
                context.dispatch('setError', err);
            });
    },
    getPlanetDateLocked(context: ActionContext<Planets, RootState>, payload: { planet: string }) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .dateLocked()
            .call({ from: Address })
            .then((dateLocked: number) =>
                context.commit('SET_PLANET_DATELOCKED', { planet: payload.planet, dateLocked })
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    PLANET_retrieveStaked(context: ActionContext<Planets, RootState>, payload: { planet: string }) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .staked()
            .call({ from: Address })
            .then((staked: number) => context.commit('SET_STAKED', { planet: payload.planet, staked }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    PLANET_retrieveDetails(context: ActionContext<Planets, RootState>, payload: { planet: string }) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .dateLocked()
            .call({ from: Address })
            .then((dateLocked: number) =>
                Promise.all([
                    context.dispatch('PLANET_retrieveStaked', { planet: payload.planet }),
                    context.dispatch('PLANET_retrieveMinHold', { planet: payload.planet }),
                    context.dispatch('PLANET_dateLocked', { planet: payload.planet }),
                    context.dispatch('PLANET_retrievePlanetYield', { planet: payload.planet }),
                    context.dispatch('SAT_getSatBalanceOfBatch', {
                        address: payload.planet,
                        ids: Object.keys(SHIP_INFO)
                    })
                ])
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    PLANET_retrieveMinHold(context: ActionContext<Planets, RootState>, payload: { planet: string }) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .minHold()
            .call({ from: Address })
            .then((minHold: number) =>
                context.commit('SET_PLANET_MINHOLD', { planet: payload.planet, minHold })
            )
            .catch((err: Error) => context.dispatch('setError', err));
    },
    getPlanetTokenId(context: ActionContext<Planets, RootState>, payload: { planet: string }) {
        const { Address, Planet } = context.getters;
        const ProxyPlanet = Planet(payload.planet);
        ProxyPlanet.methods
            .tokenId()
            .call({ from: Address })
            .then((tokenId: number) =>
                context.commit('SET_PLANET_TOKEN_ID', { planet: payload.planet, tokenId })
            )
            .then(() => Promise.resolve())
            .catch((err: Error) => context.dispatch('setError', err));
    },
    async PLANET_retrievePlanetSats(
        context: ActionContext<Planets, RootState>,
        payload: { planet: string; ids: number[] }
    ) {
        const { Sat, Address } = context.getters;
        const accounts = new Array(payload.ids.length).fill(payload.planet);
        Sat.methods
            .balanceOfBatch(payload.ids, accounts)
            .call({ from: Address })
            .then(async (balances: number[]) => await context.commit('SET_PLANET_SATS_BALANCES', balances))
            .catch((err: Error) => context.dispatch('setError', err));
    },

    PLANET_setTokenIdToProxy(
        context: ActionContext<Planets, RootState>,
        payload: { proxy: string; tokenId: number }
    ) {
        context.commit('SET_TOKEN_ID_TO_PROXY', { proxy: payload.proxy, tokenId: payload.tokenId });
    }
};
