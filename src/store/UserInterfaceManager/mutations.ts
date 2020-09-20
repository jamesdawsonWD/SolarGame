import { MutationTree } from 'vuex';
import { UserInterfaceManager, Modal } from '../types';

export const mutations: MutationTree<UserInterfaceManager> = {
    SET_ISLOADING: (state: UserInterfaceManager, payload: boolean) =>
        (state.isLoading = payload),
    SET_MODAL_STATE: (state: UserInterfaceManager, payload: Modal) =>
        (state.modal = payload)
};
