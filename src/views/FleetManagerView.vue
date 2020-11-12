<template>
    <div class="dashboard" v-if="UIM_IsLoading == false">
        <div class="utility-bar">
            <div class="solar-balance">
                <Solar class="img" />
                <h1>{{ SOLAR_getBalance }}</h1>
            </div>
            <div class="sat-balance"></div>
            <div class="fhr-balance">
                <Planet class="img" />
                <h1>{{ FHR_getBalance.length }}</h1>
            </div>
        </div>
        <div v-if="false" class="button-menu">
            <Button
                title="Mint Solar"
                @clicked="TREASURY_testMintSolar({ to: Address, amount: 1000 })"
                buttonStyle="primary"
            ></Button>
            <Button
                title="Mint Sat"
                @clicked="TREASURY_testSendSats({ ids, amounts })"
                buttonStyle="primary"
            ></Button>
            <Button
                title="Mint Fhr"
                @clicked="GO_testFhrDiscovery({ systemType: 15 })"
                buttonStyle="primary"
            ></Button>
        </div>
        <h2 class="section-heading">Planets: (PLNTS)</h2>
        <div class="grid planets" v-if="FHR_getBalance.length > 0">
            <article
                v-for="(item, index) in FHR_getBalance"
                :key="index"
                :class="{ deactive: item == 0 }"
                @click="planetSelected(index)"
            >
                <Planet class="img" />
                <h3>{{ ships[index].viewName }}</h3>
                <h2>
                    {{ GS_getPlanetYield(item) }}
                </h2>
            </article>
        </div>
        <div v-else>
            <h2 class="section-heading">You don't own any planets.</h2>
        </div>
        <h2 class="section-heading">Ships And Tech: (SAT)</h2>
        <div class="grid">
            <article
                v-for="(item, index) in SAT_getBalances(Address)"
                :key="index"
                :class="{ deactive: item == 0 }"
            >
                <h2>Amount: {{ item }}</h2>
                <Shuttle class="img" />
                <h3>{{ ships[index].viewName }}</h3>
                <p>Amount: {{ item }}</p>
                <div class="stats">
                    <h4>Offense: {{ ships[index].offense }}</h4>
                    <h4>Defense: {{ ships[index].defense }}</h4>
                </div>
            </article>
        </div>
    </div>
</template>

<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Button from '@/components/generics/Button.vue';
import Shuttle from '@/assets/svg/shuttle.svg';
import Planet from '@/assets/svg/planet-bare.svg';
import Solar from '@/assets/svg/solarcoin.svg';
export default {
    name: 'FleetManagerView',
    components: {
        Button,
        Shuttle,
        Solar,
        Planet
    },
    data(): void {
        return {
            ships: this.$utils.SHIP_INFO,
            ids: [0, 1, 2, 3, 7],
            amounts: [1, 3, 2, 5, 1]
        };
    },
    computed: {
        ...mapGetters([
            'SAT_getBalances',
            'Address',
            'SOLAR_getBalance',
            'FHR_getBalance',
            'UIM_IsLoading',
            'GS_getPlanetYield'
        ])
    },
    methods: {
        ...mapActions([
            'UIM_setIsLoading',
            'SAT_getSatBalanceOfBatch',
            'SOLAR_retrieveBalance',
            'TREASURY_testMintSolar',
            'TREASURY_testSendSats',
            'GO_testFhrDiscovery',
            'FHR_retrieveBalance',
            'GS_retrievetokenIdToYield',
            'UIM_openModal'
        ]),
        planetSelected(id: number): void {
            console.log(id);
            this.UIM_openModal({
                show: true,
                type: 'deploy-planet',
                content: 'This planet has not yet been deployed!',
                data: {
                    tokenId: id
                }
            });
        }
    },
    mounted(): void {
        this.UIM_setIsLoading({ isLoading: true });
        this.SAT_getSatBalanceOfBatch({ ids: this.$utils.SAT_IDS, address: this.Address });
        this.FHR_retrieveBalance();
        this.SOLAR_retrieveBalance({ address: this.Address });

        const yieldsP = [];

        for (let i = 0; i < this.FHR_getBalance.length; i++) {
            yieldsP.push(this.GS_retrievetokenIdToYield({ tokenId: this.FHR_getBalance[i] }));
        }

        Promise.all(yieldsP).then(() => {
            this.UIM_setIsLoading({ isLoading: false });
        });
    }
};
</script>

<style lang="scss">
.dashboard {
    height: 100vh;
    width: 100vw;

    .utility-bar {
        display: flex;
        flex-direction: row;
        justify-content: center;
        & > * {
            margin-right: 40px;
        }

        & .solar-balance .img {
            height: 150px;
        }
        & .fhr-balance .img {
            height: 150px;
        }
    }

    .button-menu {
        display: flex;
        flex-direction: row;
        justify-content: center;
        margin: 100px;
    }
    .section-heading {
        margin-top: 45px;
    }
    & > div {
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        position: relative;
    }

    & .grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
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
            & > h3,
            h2 {
                color: var(--main-black) !important;
            }
            &:hover {
                cursor: pointer;
                transform: translateY(-10px);
            }
        }
    }
    & .planets > article {
        height: 250px;
    }
}
</style>
