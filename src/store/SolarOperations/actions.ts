import { ActionTree, ActionContext } from 'vuex';
import { RootState, SolarOperations } from '../types';
import BN from 'bignumber.js';
export const actions: ActionTree<SolarOperations, RootState> = {
    async SOLAR_retrieveBalance(
        context: ActionContext<SolarOperations, RootState>,
        payload: { address: string }
    ) {
        const { Solar } = context.getters;
        const solar = await Solar.methods.balanceOf(payload.address).call();
        context.commit('SET_SOLAR_BALANCE', solar);
    },
    async SOLAR_setAllowance(context: ActionContext<SolarOperations, RootState>, amount: number) {
        const { Solar, Address, Treasury } = context.getters;
        await Solar.methods
            .approve(Treasury._address, new BN(amount).multipliedBy(10 ** 18))
            .send({ from: Address });
    }
};
