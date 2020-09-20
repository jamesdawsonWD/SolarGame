import { ActionTree, ActionContext } from 'vuex';
import { RootState, Network } from '../types';
import Web3 from 'web3';
import Master from '@/../build/contracts/TestMaster.json';
import Tsuno from '@/../build/contracts/TestTsuno.json';
export const actions: ActionTree<Network, RootState> = {
    setupWeb3(context: ActionContext<Network, RootState>) {
        let web3;
        if (window.ethereum) {
            web3 = new Web3(window.ethereum);
            window.ethereum
                .enable()
                .then((enabled: boolean) => console.log(enabled));
            web3.eth.ens;
        } else if (window.web3) {
            web3 = new Web3(window.web3.currentProvider);
        } else {
            // TODO better handle of metamask
            window.alert(
                'Non-Ethereum browser detected. You should consider trying MetaMask!'
            );
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
    async bootstrapContracts(
        context: ActionContext<Network, RootState>,
        payload
    ) {
        console.log(payload);
        const setupWeb3 = context.dispatch('setupWeb3');
        const network = context.dispatch('getNetworkData');
        const address = context.dispatch('getAddress');
        await Promise.all([setupWeb3, network, address]);
        await context.dispatch('setupMaster');
        await context.dispatch('setupTsuno');
    },

    async setupMaster(context: ActionContext<Network, RootState>) {
        const { Web3, NetworkId } = context.getters;
        const networks: Networks = Master.networks;
        const master = new Web3.eth.Contract(
            Master.abi,
            networks['5777'].address
        );
        context.commit('SET_MASTER_CONTRACT', master);
    },

    async setupTsuno(context: ActionContext<Network, RootState>) {
        const { Web3 } = context.getters;
        const networks: Networks = Tsuno.networks;
        console.log(networks['5777'].address);
        const tsuno = new Web3.eth.Contract(
            Tsuno.abi,
            networks['5777'].address
        );
        console.log(tsuno);
        context.commit('SET_TSUNO_CONTRACT', tsuno);
    }
};

interface Networks {
    [key: string]: Record<string, any>;
}
