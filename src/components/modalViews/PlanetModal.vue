<template>
    <div class="deploy-planet-modal">
        <div class="space-window">
            <Planet class="svg" />
        </div>
        <Button title="Send Fleet" @clicked="investSats" buttonStyle="primary"></Button>
        <Button title="Withdraw Fleet" @clicked="deploy" buttonStyle="primary"></Button>
        <Button
            title="Approve Solar"
            @clicked="SOLAR_setAllowance({ address: proxyAddress, amount: 10000 })"
            buttonStyle="primary"
        ></Button>
        <Button
            title="Approve Sats"
            @clicked="SAT_approvalForAllSats({ address: proxyAddress })"
            buttonStyle="primary"
        ></Button>
        <Button title="Invest Solar" @clicked="investSolar" buttonStyle="primary"></Button>
        <Button title="Withdraw Solar" @clicked="withdrawSolar" buttonStyle="primary"></Button>
        <div class="info">
            <h2>Amount Staked: {{ PLANET_getBalance({ planet: proxyAddress }) }}</h2>
            <h3>Planet Yield: {{ PLANET_getYield({ planet: proxyAddress }) }}% APY</h3>
            <h3>
                Mininum Stake Hold: {{ PLANET_getMinHold({ planet: proxyAddress }) | secondsToDays }} days
            </h3>
            <h3>Address: {{ proxyAddress }}</h3>
        </div>
        <div class="grid">
            <article
                v-for="(item, index) in SAT_getBalances(proxyAddress)"
                :key="index"
                :class="{ deactive: item == 0 }"
            >
                <h2>Amount: {{ item }}</h2>
                <Shuttle class="img" />
                <h3>{{ ships[index].viewName }}</h3>
                <div class="stats">
                    <h4>Offense: {{ ships[index].offense }}</h4>
                    <h4>Defense: {{ ships[index].defense }}</h4>
                </div>
            </article>
        </div>
    </div>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Button from '@/components/generics/Button.vue';
import Planet from '@/assets/svg/planet-bare.svg';
import Shuttle from '@/assets/svg/shuttle.svg';

@Component({
    components: {
        Button,
        Planet,
        Shuttle
    },
    computed: {
        ...mapGetters([
            'PLANET_getYield',
            'PLANET_getInfo',
            'PLANET_getMinHold',
            'PLANET_getBalance',
            'SAT_getBalances',
            'Address'
        ])
    },
    data(): void {
        return {
            ships: this.$utils.SHIP_INFO,
            ids: [0, 1, 2, 3, 7],
            amounts: [1, 3, 2, 5, 1]
        };
    },
    props: ['tokenId', 'proxyAddress'],
    methods: {
        ...mapActions([
            'GO_deployPlanet',
            'closeModal',
            'PLANET_depositSolar',
            'SOLAR_setAllowance',
            'PLANET_depositSats',
            'SAT_approvalForAllSats'
        ]),
        investSolar(): void {
            this.PLANET_depositSolar({ planet: this.proxyAddress, amount: 1000 });
        },
        withdrawSolar(): void {
            this.PLANET_withdrawSolar({ planet: this.proxyAddress, amount: this.PLANET_getBalance });
        },
        investSats(): void {
            this.PLANET_depositSats({ planet: this.proxyAddress, ids: this.ids, amounts: this.amounts });
        },
        withdrawSats(): void {
            this.PLANET_depositSat({ planet: this.proxyAddress, ids: this.ids, amounts: this.amounts });
        }
    }
})
export default class PlanetModal extends Vue {
    @Prop() private amount!: number;
}
</script>
<style scoped lang="scss">
.deploy-planet-modal {
    height: 80vh;
    width: 60vw;
    overflow-y: scroll;
    h3,
    h2 {
        color: var(--main-black);
    }
    .space-window {
        height: 500px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        border-radius: 25px;
        align-items: center;
        background: var(--background-color);
    }
    .grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-template-rows: repeat(3, auto);
        grid-gap: 50px;
        justify-content: center;
        align-items: center;
        margin: 50px 0;
        & article {
            height: 450px;
            width: 300px;
            background: var(--offset-white);
            border-radius: 30px;
            margin: auto;
            padding: 30px;
            transition: 0.3s;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            -webkit-box-shadow: 9px 14px 22px -6px rgba(0, 0, 0, 0.75);
            -moz-box-shadow: 9px 14px 22px -6px rgba(0, 0, 0, 0.75);
            box-shadow: 9px 14px 22px -6px rgba(0, 0, 0, 0.75);
            & > .img {
                width: 100%;
            }
            & > .stats {
                display: flex;
                justify-content: space-between;
                margin-top: 15px;
                padding: 8px;

                & h4 {
                    color: var(--main-black) !important;
                }
            }
            & > h3 {
                color: var(--main-black) !important;
            }
            &:hover {
                cursor: pointer;
                transform: translateY(-10px);
            }
        }
    }
    .info {
        display: flex;
        flex-direction: column;
        text-align: left;

        h3 {
            margin-top: 30px;
        }
    }
    & .svg {
        height: 70%;
        width: 70%;
    }
}
</style>
