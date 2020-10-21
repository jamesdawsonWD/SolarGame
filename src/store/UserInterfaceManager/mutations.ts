import { StarPosition } from './../types';
import { MutationTree } from 'vuex';
import { UserInterfaceManager, Modal } from '../types';

export const mutations: MutationTree<UserInterfaceManager> = {
    SET_ISLOADING: (state: UserInterfaceManager, payload: boolean) => (state.isLoading = payload),
    SET_MODAL_STATE: (state: UserInterfaceManager, payload: Modal) => (state.modal = payload),
    SET_ERROR: (state: UserInterfaceManager, err: Error) => (state.error = err),
    SET_SUCCESS_MESSAGE: (state: UserInterfaceManager, msg: string) => (state.success.msg = msg),
    SET_LOCAL_STAR_POSITION: (state: UserInterfaceManager, pos: StarPosition) =>
        (state.localStarPosition = pos)
};
