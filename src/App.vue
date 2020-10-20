<template>
    <div id="app"></div>
</template>
<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import DepositForm from '@/components/forms/DepositForm.vue';
import Modal from '@/components/generics/Modal.vue';
import Button from '@/components/generics/Button.vue';
import { Deposit } from '@/store/types';
import { SECONDS_IN_A_DAY, advanceTime } from '@/utils';
export default {
    name: 'App',
    computed: {
        // ...mapGetters([
        //     'Address',
        //     'Balance',
        //     'TsunoBalance',
        //     'ShowModal',
        //     'DateUnlocked',
        //     'RecentError'
        // ])
    },
    components: {
        DepositForm,
        Modal,
        Button
    },
    methods: {
        // ...mapActions([
        //     'bootstrapContracts',
        //     'getBalance',
        //     'mintTsuno',
        //     'getTsunoBalance',
        //     'deposit',
        //     'closeModal',
        //     'getDateUnlocked',
        //     'withdraw',
        //     'emergencyWithdraw'
        // ]),
        // depositAmount: function(deposit: Deposit) {
        //     this.deposit(deposit);
        // }
    },

    async mounted() {
        // await this.bootstrapContracts();
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
