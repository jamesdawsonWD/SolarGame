import { ActionTree, ActionContext } from 'vuex';
import { RootState, TsunoOperations } from '../types';
import BN from 'bignumber.js';
export const actions: ActionTree<TsunoOperations, RootState> = {
    // async setupMaster(context: ActionContext<FundOperations, RootState>) {
    //     const { Web3, NetworkId } = context.getters;
    //     console.log(Master.networks);
    //     // const lootControlsContract = new Web3.eth.Contract(Master.abi, Master.networks[NetworkId].address);
    //     // context.commit('ADD_LOOTCONTROL_CONTRACT', lootControlsContract);
    // }
    // //     const { Web3 } = context.getters;
    //     const network = await Web3.eth.net.getNetworkType();
    //     const networkId = await Web3.eth.net.getId();
    //     const currentBlock = await Web3.eth.getBlockNumber();
    //     context.commit('SET_NETWORK_DATA', {
    //         network,
    //         networkId,
    //         currentBlock
    //     });
    // },
    // async getAddress(context: ActionContext<FundOperations, RootState>) {
    //     const { Web3 } = context.getters;
    //     const accounts = await Web3.eth.getAccounts();
    //     context.commit('SET_ADDRESS', accounts[0]);
    // },
    // async bootstrapContracts(context: ActionContext<FundOperations, RootState>) {
    //     const setupWeb3 = context.dispatch('setupWeb3');
    //     const network = context.dispatch('getNetworkData');
    //     const address = context.dispatch('getAddress');
    //     await Promise.all([setupWeb3, network, address]);
    // }
    async getTsunoBalance(context: ActionContext<TsunoOperations, RootState>) {
        const { Tsuno, Address } = context.getters;
        const tsuno = await Tsuno.methods.balanceOf(Address).call();
        context.commit('SET_TSUNO_BALANCE', tsuno);
    },
    async mintTsuno(context: ActionContext<TsunoOperations, RootState>) {
        const { Tsuno, Address } = context.getters;
        await Tsuno.methods
            .testMint(Address, new BN(1).multipliedBy(10 ** 18))
            .send({ from: Address });
        context.dispatch('getTsunoBalance');
    },
    async setAllowance(
        context: ActionContext<TsunoOperations, RootState>,
        amount: number
    ) {
        const { Tsuno, Address, Master } = context.getters;
        console.log(amount);
        await Tsuno.methods
            .approve(Master._address, new BN(amount).multipliedBy(10 ** 18))
            .send({ from: Address });
    }
};
