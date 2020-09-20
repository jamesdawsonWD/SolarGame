import Vue from 'vue';
import Vuex from 'vuex';
import { network } from './Network';
import { tsunoOperations } from './TsunoOperations';
import { fundOperations } from './FundOperations';
import { userInterfaceManager } from './UserInterfaceManager/index';
Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        version: '1.0.0' // a simple property
    },
    mutations: {},
    actions: {},
    modules: { network, fundOperations, tsunoOperations, userInterfaceManager },
    plugins: []
});
