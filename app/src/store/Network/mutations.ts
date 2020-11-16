import { MutationTree } from 'vuex';
import { Network, NetworkData } from '../types';

export const mutations: MutationTree<Network> = {
    SET_WEB3: (state: Network, payload: any) => (state.web3 = payload),
    SET_NETWORK_DATA: (state: Network, payload: NetworkData) => (state.networkData = payload),
    SET_ADDRESS: (state: Network, payload: string) => (state.userAddress = payload),
    SET_GAMEOPERATIONS: (state: Network, payload: any) => (state.contracts.gameOperations = payload),
    SET_SOLAR_CONTRACT: (state: Network, payload: any) => (state.contracts.solar = payload),
    SET_SAT_CONTRACT: (state: Network, payload: any) => (state.contracts.sat = payload),
    SET_FHR_CONTRACT: (state: Network, payload: any) => (state.contracts.fhr = payload),
    SET_GAMESTORAGE: (state: Network, payload: any) => (state.contracts.gameStorage = payload),
    SET_TREASURY: (state: Network, payload: any) => (state.contracts.treasury = payload),
    ADD_VISITED_PLANET: (state: Network, payload: { planet: any; address: string }) => {
        state.contracts.planets = {
            ...state.contracts.planets,
            ...{
                [payload.address]: payload.planet
            }
        };
    }
};
