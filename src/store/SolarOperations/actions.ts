import { ActionTree, ActionContext } from 'vuex';
import { RootState, SolarOperations } from '../types';
import BN from 'bignumber.js';
export const actions: ActionTree<SolarOperations, RootState> = {
    async getSolarBalance(context: ActionContext<SolarOperations, RootState>) {
        const { Solar, Address } = context.getters;
        const solar = await Solar.methods.balanceOf(Address).call();
        context.commit('SET_SOLAR_BALANCE', solar);
    },
    async setAllowance(
        context: ActionContext<SolarOperations, RootState>,
        amount: number
    ) {
        const { Solar, Address, Treasury } = context.getters;
        await Solar.methods
            .approve(Treasury._address, new BN(amount).multipliedBy(10 ** 18))
            .send({ from: Address });
    }
};
