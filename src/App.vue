<template>
    <div id="app">
        <div id="nav">
            <router-link to="/">Map</router-link> | <router-link to="/fleetManager">Fleet</router-link> |
            <router-link to="/market">Market</router-link>
        </div>
        <router-view />
        <Modal v-if="ShowModal" @close="UIM_closeModal" />
    </div>
</template>
<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Modal from '@/components/generics/Modal.vue';
// import Button from '@/components/generics/Button.vue';
export default {
    name: 'App',
    computed: {
        ...mapGetters([
            //     'Address',
            //     'Balance',
            //     'TsunoBalance',
            'ShowModal'
            //     'DateUnlocked',
            //     'RecentError'
        ])
    },
    components: {
        // DepositForm,
        Modal
        // Button
    },
    methods: {
        ...mapActions(['bootstrapContracts', 'GS_retrieveBoundaries', 'UIM_closeModal'])
        // depositAmount: function(deposit: Deposit) {
        //     this.deposit(deposit);
        // }
    },

    async mounted() {
        await this.bootstrapContracts();
        await this.GS_retrieveBoundaries();

        // await this.getBalance();
        // await this.getTsunoBalance();
        // await this.getDateUnlocked();
    }
};
</script>
<style lang="scss">
#app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    height: 100vh;
    background: #020c3d;
}

#nav {
    padding: 30px;
    a {
        font-weight: bold;
        color: #2c3e50;

        &.router-link-exact-active {
            color: #42b983;
        }
    }
}
</style>
