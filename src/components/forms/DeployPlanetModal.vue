<template>
    <div class="deploy-planet-modal">
        <Planet class="svg" />
        <Button title="Deploy" @clicked="deploy" buttonStyle="primary"></Button>
    </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';
import { mapActions } from 'vuex';
import Button from '@/components/generics/Button.vue';
import Planet from '@/assets/svg/planet-bare.svg';

@Component({
    components: {
        Button,
        Planet
    },
    data() {
        return {
            deployed: false
        };
    },
    props: ['tokenId'],
    methods: {
        ...mapActions(['GO_deployPlanet', 'closeModal']),
        deploy(): void {
            this.GO_deployPlanet({ tokenId: this.tokenId });
        }
    }
})
export default class AllowanceForm extends Vue {
    @Prop() private amount!: number;
}
</script>
<style scoped lang="scss">
.deploy-planet-modal {
    height: 50vh;
    width: 60vw;
    display: flex;
    flex-direction: column;
    justify-content: center;
    border-radius: 25px;
    align-items: center;
    background: var(--background-color);
    & .svg {
        height: 70%;
        width: 70%;
    }
}
</style>
