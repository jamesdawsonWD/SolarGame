import { state } from './index';
import { ActionTree, ActionContext } from 'vuex';
import { RootState, Network } from '../types';
import Web3 from 'web3';
import Treasury from '@/../build/contracts/TestTreasury.json';
import GameOperations from '@/../build/contracts/TestGameOperations.json';
import Solar from '@/../build/contracts/SolarToken.json';
import Sat from '@/../build/contracts/TestShipsAndTechnology.json';
import FHR from '@/../build/contracts/FederalHarvestingRights.json';
import GameStorage from '@/../build/contracts/GameStorage.json';
import Planet from '@/../build/contracts/Planet.json';

export const actions: ActionTree<Network, RootState> = {
    setupWeb3(context: ActionContext<Network, RootState>) {
        let web3;
        if (window.ethereum) {
            web3 = new Web3(window.ethereum);
            window.ethereum.enable().then((enabled: boolean) => console.log(enabled));
            web3.eth.ens;
        } else if (window.web3) {
            web3 = new Web3(window.web3.currentProvider);
        } else {
            // TODO better handle of metamask
            window.alert('Non-Ethereum browser detected. You should consider trying MetaMask!');
        }
        context.commit('SET_WEB3', web3);
    },
    async getNetworkData(context: ActionContext<Network, RootState>) {
        const { Web3 } = context.getters;
        const network = await Web3.eth.net.getNetworkType();
        const networkId = await Web3.eth.net.getId();
        const currentBlock = await Web3.eth.getBlockNumber();
        context.commit('SET_NETWORK_DATA', {
            network,
            networkId,
            currentBlock
        });
    },
    async getAddress(context: ActionContext<Network, RootState>) {
        const { Web3 } = context.getters;
        const accounts = await Web3.eth.getAccounts();
        context.commit('SET_ADDRESS', accounts[0]);
    },
    async bootstrapContracts(context: ActionContext<Network, RootState>, payload) {
        const setupWeb3 = context.dispatch('setupWeb3');
        const network = context.dispatch('getNetworkData');
        const address = context.dispatch('getAddress');
        await Promise.all([setupWeb3, network, address]);
        await context.dispatch('setupGameStorage');
        await context.dispatch('setupTreasury');
        await context.dispatch('setupGameOperations');
        await context.dispatch('setupTreasury');
        await context.dispatch('setupSolar');
        await context.dispatch('setupSat');
        await context.dispatch('setupFhr');
    },

    async setupGameOperations(context: ActionContext<Network, RootState>) {
        const { Web3, NetworkId } = context.getters;
        const networks: Networks = GameOperations.networks;
        const master = new Web3.eth.Contract(GameOperations.abi, networks['5777'].address);
        context.commit('SET_GAMEOPERATIONS', master);
    },
    async setupGameStorage(context: ActionContext<Network, RootState>) {
        const { Web3, NetworkId } = context.getters;
        const networks: Networks = GameStorage.networks;
        const storage = new Web3.eth.Contract(GameStorage.abi, networks['5777'].address);
        console.log(storage);
        context.commit('SET_GAMESTORAGE', storage);
    },
    async setupTreasury(context: ActionContext<Network, RootState>) {
        const { Web3, NetworkId } = context.getters;
        const networks: Networks = Treasury.networks;
        const treasury = new Web3.eth.Contract(Treasury.abi, networks['5777'].address);
        context.commit('SET_TREASURY', treasury);
    },

    async setupSolar(context: ActionContext<Network, RootState>) {
        const { Web3 } = context.getters;
        const networks: Networks = Solar.networks;
        const solar = new Web3.eth.Contract(Solar.abi, networks['5777'].address);
        context.commit('SET_SOLAR_CONTRACT', solar);
    },
    async setupSat(context: ActionContext<Network, RootState>) {
        const { Web3 } = context.getters;
        const networks: Networks = Sat.networks;
        const sat = new Web3.eth.Contract(Sat.abi, networks['5777'].address);
        context.commit('SET_SAT_CONTRACT', sat);
    },
    async setupFhr(context: ActionContext<Network, RootState>) {
        const { Web3 } = context.getters;
        const networks: Networks = FHR.networks;
        const fhr = new Web3.eth.Contract(FHR.abi, networks['5777'].address);
        context.commit('SET_FHR_CONTRACT', fhr);
    },
    async setupPlanet(context: ActionContext<Network, RootState>, payload: string) {
        const { Web3 } = context.getters;
        const planet = new Web3.eth.Contract(Planet.abi, payload);
        context.commit('ADD_VISITED_PLANET', planet);
    }
};

interface Networks {
    [key: string]: Record<string, any>;
}
