<template>
    <div id="app">
        <div id="nav">
            <Logo class="logo" />
            <div>
                <router-link to="/"><Map class="nav-icon"/></router-link>
                <router-link to="/fleetManager"><Fleet class="nav-icon"/></router-link>
            </div>
        </div>
        <router-view />
        <Modal v-if="ShowModal" @close="UIM_closeModal" />
    </div>
</template>
<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Logo from '@/assets/svg/logo.svg';
import Map from '@/assets/svg/map-nav.svg';
import Fleet from '@/assets/svg/fleet-nav.svg';
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
        Modal,
        Logo,
        Map,
        Fleet
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
    padding: 15px;
    height: 150px;
    width: 100%;
    position: relative;
    display: flex;
    justify-content: space-between;
    top: 0;

    div > * {
        margin-right: 100px;

        .nav-icon {
            height: 100px;
            transition: 0.5s;
            &:hover {
                transform: translateY(10px);
            }
        }
    }
    .logo {
        margin-left: 90px;
        top: 10px;
        height: 100px;
    }
    a {
        font-weight: bold;
        color: #2c3e50;

        &.router-link-exact-active {
            color: #42b983;
        }
    }
}
</style>
