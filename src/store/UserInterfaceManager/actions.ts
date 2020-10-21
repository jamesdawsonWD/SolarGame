import { StarPosition } from './../types';
import { ActionTree, ActionContext } from 'vuex';
import { RootState, UserInterfaceManager, Modal } from '../types';
export const actions: ActionTree<UserInterfaceManager, RootState> = {
    openModal(context: ActionContext<UserInterfaceManager, RootState>, payload: Modal) {
        context.commit('SET_MODAL_STATE', payload);
    },

    closeModal(context: ActionContext<UserInterfaceManager, RootState>) {
        const modal = {
            show: false,
            content: ''
        };
        context.commit('SET_MODAL_STATE', modal);
    },
    setSuccessMessage(context: ActionContext<UserInterfaceManager, RootState>, msg: string) {
        context.commit('SET_SUCCESS_MESSAGE', msg);
    },
    setError(context: ActionContext<UserInterfaceManager, RootState>, err: Error) {
        context.commit('SET_ERROR', err);
    },
    UIM_setLocalStarPosition(
        context: ActionContext<UserInterfaceManager, RootState>,
        pos: StarPosition
    ) {
        context.commit('SET_LOCAL_STAR_POSITION', pos);
    }
};
