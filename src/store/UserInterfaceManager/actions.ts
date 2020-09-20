import { ActionTree, ActionContext } from 'vuex';
import { RootState, UserInterfaceManager, Modal } from '../types';
export const actions: ActionTree<UserInterfaceManager, RootState> = {
    openModal(
        context: ActionContext<UserInterfaceManager, RootState>,
        payload: Modal
    ) {
        context.commit('SET_MODAL_STATE', payload);
    },

    closeModal(context: ActionContext<UserInterfaceManager, RootState>) {
        const modal = {
            show: false,
            content: ''
        };
        context.commit('SET_MODAL_STATE', modal);
    }
};
