<template>
    <transition name="modal">
        <div class="modal-mask">
            <div class="modal-wrapper">
                <div class="modal-container">
                    <div class="modal-header">
                        <h2 name="header">
                            {{ Modal.content }}
                        </h2>
                    </div>

                    <div class="modal-body">
                        <DeployPlanetModal
                            v-if="Modal.type == 'deploy-planet'"
                            :tokenId="Modal.data.tokenId"
                        ></DeployPlanetModal>
                        <PlanetModal
                            v-if="Modal.type == 'planet'"
                            :tokenId="Modal.data.tokenId"
                            :proxyAddress="Modal.data.proxyAddress"
                        ></PlanetModal>
                    </div>

                    <div class="modal-footer">
                        <slot name="footer">
                            <Button title="Close" @clicked="$emit('close')"> </Button>
                        </slot>
                    </div>
                </div>
            </div>
        </div>
    </transition>
</template>

<script lang="ts">
import { mapGetters } from 'vuex';
import { Component, Prop, Vue } from 'vue-property-decorator';
import DepositForm from '@/components/forms/DepositForm.vue';
import DeployPlanetModal from '@/components/modalViews/DeployPlanetModal.vue';
import PlanetModal from '@/components/modalViews/PlanetModal.vue';
import Button from '@/components/generics/Button.vue';

@Component({
    components: {
        DepositForm,
        DeployPlanetModal,
        PlanetModal,
        Button
    },
    computed: {
        ...mapGetters(['Modal'])
    }
})
export default class Modal extends Vue {
    @Prop() private msg!: string;
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped lang="scss">
.modal-mask {
    position: fixed;
    z-index: 9998;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, 0.5);
    display: table;
    transition: opacity 0.3s ease;

    h2,
    h3 {
        color: var(--main-black);
    }
}
.modal-wrapper {
    display: table-cell;
    vertical-align: middle;
}
.modal-container {
    min-width: 300px;
    height: 90vh;
    width: 70%;
    margin: 0px auto;
    padding: 20px 30px;
    background-color: var(--main-white);
    border-radius: 2px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
    transition: all 0.3s ease;
    border-radius: 25px;
    font-family: Helvetica, Arial, sans-serif;
}

.modal-header {
    margin: 35px;
    color: #42b983;
}
.modal-body {
    margin: 20px 0;
    height: 80%;
    display: flex;
    justify-content: center;
}
.modal-default-button {
    float: right;
} /* * The following styles are
auto-applied to elements with * transition="modal" when their visibility is
toggled * by Vue.js. * * You can easily play with the modal transition by
editing * these styles. */
.modal-enter {
    opacity: 0;
}
.modal-leave-active {
    opacity: 0;
}
.modal-enter .modal-container,
.modal-leave-active .modal-container {
    -webkit-transform: scale(1.1);
    transform: scale(1.1);
}
</style>
