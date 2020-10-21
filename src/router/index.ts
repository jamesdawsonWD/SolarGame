import Vue from 'vue';
import VueRouter, { RouteConfig } from 'vue-router';
import MapView from '../views/MapView.vue';
import FleetManagerView from '../views/FleetManagerView.vue';
import PlanetView from '../views/PlanetView.vue';
import MarketView from '../views/PlanetView.vue';
Vue.use(VueRouter);

const routes: Array<RouteConfig> = [
    {
        path: '/',
        name: 'MapView',
        component: MapView
    },
    {
        path: '/fleetManager',
        name: 'FleetManagerView',
        component: FleetManagerView
    },
    {
        path: '/planet',
        name: 'PlanetView',
        component: PlanetView
    },
    {
        path: '/market',
        name: 'MarketView',
        component: MarketView
    }
];

const router = new VueRouter({
    routes
});

export default router;
