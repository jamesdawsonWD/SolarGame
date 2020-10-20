import { ActionTree, ActionContext } from 'vuex';
import { RootState, GameStorage, StarPosition } from '../types';
import BN from 'bignumber.js';
export const actions: ActionTree<GameStorage, RootState> = {
    getCurrentStarPosition(context: ActionContext<GameStorage, RootState>) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .getMasterFleetPosition(Address)
            .call({ from: Address })
            .then((pos: StarPosition) => context.commit('SET_CURRENT_STAR_POSITION', pos))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    getProxyAddressToTokenId(context: ActionContext<GameStorage, RootState>, address: string) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .getProxyAddressToTokenId(address)
            .call({ from: Address })
            .then((tokenId: number) => context.commit('SET_PLANET_TO_TOKEN_ID', { address, tokenId }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    getTokenIdToProxyAddress(context: ActionContext<GameStorage, RootState>, tokenId: number) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .getTokenIdToProxyAddress(tokenId)
            .call({ from: Address })
            .then((address: string) => context.commit('SET_TOKEN_ID_TO_PLANET', { tokenId, address }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    getStarSystemType(context: ActionContext<GameStorage, RootState>, pos: StarPosition) {
        const { GameStorage, Address } = context.getters;
        const posP = [pos.quadrant, pos.sector, pos.district, pos.star];
        GameStorage.methods
            .getStarSystemType(posP)
            .call({ from: Address })
            .then((type: any) => context.commit('SET_STAR_POSITION_TYPE', { pos, type }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    batchGetSatInfo(context: ActionContext<GameStorage, RootState>, ids: number[]) {
        const { GameStorage, Address } = context.getters;
        GameStorage.methods
            .batchGetSatInfo(ids)
            .call({ from: Address })
            .then((info: any) => context.commit('SET_ALL_SAT_INFO', { info }))
            .catch((err: Error) => context.dispatch('setError', err));
    },
};
