import { GetterTree } from 'vuex';
import { RootState, Network } from '../types';

export const getters: GetterTree<Network, RootState> = {
    Web3: state => state.web3,
    Address: state => state.userAddress,
    Network: state => state.networkData.network,
    NetworkId: (state): number => state.networkData.networkId,
    GameOperations: state => state.contracts.gameOperations,
    Solar: state => state.contracts.solar,
    Fhr: state => state.contracts.fhr,
    Sat: state => state.contracts.sat,
    Treasury: state => state.contracts.treasury,
    GameStorage: state => state.contracts.gameStorage,
    Planet: (state) => (planet: string) => state.contracts.planets[planet],
};
