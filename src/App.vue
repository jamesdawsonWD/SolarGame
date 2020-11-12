<template>
    <div id="app">
        <div id="nav">
            <Logo class="logo" />
            <div>
                <router-link to="/"><Map class="nav-icon"/></router-link>
                <router-link to="/fleetManager"><Fleet class="nav-icon"/></router-link>
            </div>
        </div>
        <Background class="background" />
        <router-view />
        <Modal v-if="ShowModal" @close="UIM_closeModal" />
    </div>
</template>
<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Logo from '@/assets/svg/logo.svg';
import Map from '@/assets/svg/map-nav.svg';
import Background from '@/assets/svg/background.svg';
import Fleet from '@/assets/svg/fleet-nav.svg';
import Modal from '@/components/generics/Modal.vue';
// import Button from '@/components/generics/Button.vue';
export default {
    name: 'App',
    computed: {
        ...mapGetters(['ShowModal'])
    },
    components: {
        // DepositForm,
        Modal,
        Logo,
        Map,
        Background,
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
}

.background {
    position: fixed;
    top: 0;
    left: -1px;
    width: 102vw;
    z-index: -100;
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
- cors 2.8.5 - express 4.17.1 - handlebars 4.7.6 - moment 2.29.1 - mongodb 2.2.36 - mongoose 4.13.21 -
mongoose-paginate 5.0.3 - mongoose-timestamps 0.0.1 - mongoose-unique-validator 1.0.6 - nodemailer 6.4.15
devDependencies: - dotenv 8.2.0 - nodemon 2.0.6 monogodb
