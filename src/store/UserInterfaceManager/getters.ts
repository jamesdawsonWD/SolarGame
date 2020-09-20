import { GetterTree } from 'vuex';
import { RootState, UserInterfaceManager } from '../types';

export const getters: GetterTree<UserInterfaceManager, RootState> = {
    IsLoading: state => state.isLoading,
    Modal: state => state.modal,
    ShowModal: state => state.modal.show
};
