import { RootState, GameStorageOperations, StarPosition } from './../types';
import { ActionTree, ActionContext } from 'vuex';
import BN from 'bignumber.js';
export const actions: ActionTree<GameStorageOperations, RootState> = {
    GS_retrieveCurrentStarPosition(context: ActionContext<GameStorageOperations, RootState>) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .getMasterFleetPosition(Address)
            .call({ from: Address })
            .then((pos: StarPosition) => context.commit('SET_CURRENT_STAR_POSITION', pos))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    GS_retrieveProxyAddressToTokenId(
        context: ActionContext<GameStorageOperations, RootState>,
        address: string
    ) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .getProxyAddressToTokenId(address)
            .call({ from: Address })
            .then((tokenId: number) => context.commit('SET_PLANET_TO_TOKEN_ID', { address, tokenId }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    GS_retrieveTokenIdToProxyAddress(
        context: ActionContext<GameStorageOperations, RootState>,
        tokenId: number
    ) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .getTokenIdToProxyAddress(tokenId)
            .call({ from: Address })
            .then((address: string) => context.commit('SET_TOKEN_ID_TO_PLANET', { tokenId, address }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    GS_retrieveStarSystemType(context: ActionContext<GameStorageOperations, RootState>, pos: StarPosition) {
        const { GameStorage, Address } = context.getters;
        const posP = [pos.quadrant, pos.sector, pos.district, pos.star];
        GameStorage.methods
            .getStarSystemType(posP)
            .call({ from: Address })
            .then((systemType: any) => {
                context.dispatch('GS_setStarSystemType', { pos, systemType });
            })
            .catch((err: Error) => context.dispatch('setError', err));
    },
    GS_batchGetSatInfo(context: ActionContext<GameStorageOperations, RootState>, ids: number[]) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .batchGetSatInfo(ids)
            .call({ from: Address })
            .then((info: any) => context.commit('SET_ALL_SAT_INFO', { info }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    GS_retrieveBoundaries(context: ActionContext<GameStorageOperations, RootState>) {
        const { GameStorage, Address } = context.getters;
        console.log(GameStorage);
        GameStorage.methods
            .getBoundaries()
            .call({ from: Address })
            .then((boundaries: any) =>
                context.commit('SET_BOUNDARIES', {
                    quadrant: boundaries.quadrant,
                    sector: boundaries.sector,
                    district: boundaries.district,
                    star: boundaries.star
                })
            )
            .catch((err: Error) => {
                context.dispatch('setError', err);
            });
    },

    GS_retrievetokenIdToYield(
        context: ActionContext<GameStorageOperations, RootState>,
        payload: { tokenId: number }
    ) {
        const { GameStorage, Address } = context.getters;
        console.log(GameStorage);
        GameStorage.methods
            .getTokenIdToYield(payload.tokenId)
            .call({ from: Address })
            .then((planetYield: any) => {
                console.log(planetYield);
                context.commit('GS_SET_PLANET_YIELD', {
                    tokenId: payload.tokenId,
                    planetYield
                });
            })
            .catch((err: Error) => {
                context.dispatch('setError', err);
            });
    },
    GS_setStarSystemType(
        context: ActionContext<GameStorageOperations, RootState>,
        payload: { pos: StarPosition; systemType: number }
    ) {
        console.log(payload);
        context.commit('SET_STAR_POSITION_TYPE', {
            pos: payload.pos,
            systemType: payload.systemType
        });
    }
};
