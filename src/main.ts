import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
Vue.config.productionTip = false;

new Vue({
    router,
    store,
    render: h => h(App)
}).$mount('#app');

import '@/utils/filters';

declare global {
    interface Window {
        ethereum: any;
        web3: any;
    }
}
