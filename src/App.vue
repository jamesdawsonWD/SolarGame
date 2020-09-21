<template>
    <div id="app">
        <modal v-if="ShowModal" @close="closeModal"></modal>
        <div id="nav">
            <router-link to="/">Home</router-link> |
            <router-link to="/about">About</router-link>
        </div>
        <router-view />
        <div>
            <h2>Deposited</h2>
            <div>{{ Balance | decimalsPrecision(18) | toFixed(4) }}</div>
            <h2>Available Tsuno</h2>
            <div>{{ TsunoBalance | decimalsPrecision(18) | toFixed(4) }}</div>
            <h2>Date Withdrawable</h2>
            <div>{{ DateUnlocked }}</div>
            <h2>Recent Error</h2>
            <div>{{ RecentError | json }}</div>
        </div>
        <h2>Tools</h2>
        <Button title="Get Balance" @clicked="getBalance"></Button>
        <Button
            title="Mint Tsuno"
            buttonStyle="primary"
            @clicked="mintTsuno"
        ></Button>

        <DepositForm @submitted="depositAmount"></DepositForm>
    </div>
</template>
<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import DepositForm from '@/components/forms/DepositForm.vue';
import Modal from '@/components/generics/Modal.vue';
import Button from '@/components/generics/Button.vue';
import { Deposit } from '@/store/types';
export default {
    name: 'App',
    computed: {
        ...mapGetters([
            'Address',
            'Balance',
            'TsunoBalance',
            'ShowModal',
            'DateUnlocked',
            'RecentError'
        ])
    },
    components: {
        DepositForm,
        Modal,
        Button
    },
    methods: {
        ...mapActions([
            'bootstrapContracts',
            'getBalance',
            'mintTsuno',
            'getTsunoBalance',
            'deposit',
            'closeModal',
            'getDateUnlocked'
        ]),
        depositAmount: function(deposit: Deposit) {
            this.deposit(deposit);
        }
    },

    async mounted() {
        await this.bootstrapContracts();
        await this.getBalance();
        await this.getTsunoBalance();
        await this.getDateUnlocked();
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
