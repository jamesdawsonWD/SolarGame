import { ActionTree, ActionContext } from 'vuex';
import { RootState, GameOperations, StarPosition } from './../types';
export const actions: ActionTree<GameOperations, RootState> = {
    async GO_move(context: ActionContext<GameOperations, RootState>, payload: StarPosition) {
        const { GameOperations, Address } = context.getters;
        const posP = [payload.quadrant, payload.sector, payload.district, payload.star];
        console.log(posP);
        GameOperations.methods
            .move(posP)
            .send({ from: Address })
            .then(tx => console.log(tx))
            .catch((err: Error) => context.dispatch('setError', err));
    },
    async GO_attack(
        context: ActionContext<GameOperations, RootState>,
        payload: { defender: string; turns: number }
    ) {
        const { GameOperations, Address } = context.getters;
        GameOperations.methods
            .attack(payload.defender, payload.turns)
            .send({ from: Address })
            .then((tx: any) => {
                console.log(tx);
            })
            .catch((err: Error) => context.dispatch('setError', err));
    }
};
