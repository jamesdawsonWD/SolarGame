import Vue from 'vue';
import Vuex from 'vuex';
import { network } from './Network';
import { planet } from './Planet';
import { fhrOperations } from './FhrOperations';
import { gameStorage } from './GameStorage';
import { gameOperations } from './GameOperation';
import { solarOperations } from './SolarOperations';
import { treasuryOperations } from './Treasury';
import { userInterfaceManager } from './UserInterfaceManager';
Vue.use(Vuex);

export default new Vuex.Store({
    state: {
        version: '1.0.0' // a simple property
    },
    mutations: {},
    actions: {},
    modules: {
        network,
        planet,
        fhrOperations,
        gameStorage,
        gameOperations,
        solarOperations,
        treasuryOperations,
        userInterfaceManager,
    },
    plugins: []
});
