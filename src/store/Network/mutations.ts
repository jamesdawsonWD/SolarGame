import { MutationTree } from 'vuex';
import { Network, NetworkData } from '../types';

export const mutations: MutationTree<Network> = {
    SET_WEB3: (state: Network, payload: any) => (state.web3 = payload),
    SET_NETWORK_DATA: (state: Network, payload: NetworkData) =>
        (state.networkData = payload),
    SET_ADDRESS: (state: Network, payload: string) =>
        (state.userAddress = payload),
    SET_MASTER_CONTRACT: (state: Network, payload: any) =>
        (state.master = payload),
    SET_TSUNO_CONTRACT: (state: Network, payload: any) =>
        (state.tsuno = payload)
};
