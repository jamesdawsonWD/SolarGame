<template>
    <div class="mapView">
        <div class="coordinates">
            <h2>Star Coordinates</h2>
            <h3>Quadrant: {{ starPosition.quadrant }}</h3>
            <h3>Sector: {{ starPosition.sector }}</h3>
            <h3>District: {{ starPosition.district }}</h3>
            <h3>Star: {{ starPosition.star }}</h3>
        </div>
        <div v-if="mapView == 'quadrant'" class="quadrant-map">
            <Galaxy class="map galaxy-svg" />
            <Quadrants class="map quadrants" />
            <QuadrantsHighlighted v-on:click="quadrantSelected($event)" class="map quadrants-highlights" />
        </div>
        <div v-if="mapView == 'sector'" class="map sector-map">
            <Hex20 class="sectors" v-on:click="sectorSelected($event)" />
        </div>
        <div v-if="mapView == 'district'" v-on:click="districtSelected($event)" class="map sector-map">
            <Districts class="sectors" />
        </div>
        <div v-if="mapView == 'stars'" class="map star-map">
            <Stars class="stars" v-on:click="starSelected($event)" />
        </div>
    </div>
</template>

<script lang="ts">
// @ is an alias to /src
// import HelloWorld from '@/components/HelloWorld.vue';
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Quadrants from '@/assets/svg/quadrants.svg';
import Stars from '@/assets/svg/stars.svg';
import Galaxy from '@/assets/svg/galaxy.svg';
import Districts from '@/assets/svg/districts.svg';
import QuadrantsHighlighted from '@/assets/svg/quadrants-highlight.svg';
import Hex20 from '@/assets/svg/20hex.svg';
// import Button from '@/components/generics/Button.vue';
export default {
    name: 'MapView',
    computed: {
        ...mapGetters(['GS_getBoundaries'])
    },
    components: {
        Quadrants,
        QuadrantsHighlighted,
        Hex20,
        Districts,
        Stars,
        Galaxy
        // DepositForm,
        // Modal,
        // Button
    },
    data(): void {
        return {
            mapView: 'quadrant',
            starPosition: {
                quadrant: 0,
                sector: 0,
                district: 0,
                star: 0
            }
        };
    },
    methods: {
        // depositAmount: function(deposit: Deposit) {
        //     this.deposit(deposit);
        // }
        ...mapActions(['GS_retrieveStarSystemType', 'UIM_setLocalStarPosition']),
        quadrantSelected(e): void {
            this.starPosition.quadrant = e.path[0].id;
            this.mapView = 'sector';
        },
        sectorSelected(e): void {
            this.starPosition.sector = e.path[0].id;
            this.mapView = 'district';
        },
        districtSelected(e): void {
            this.starPosition.district = e.path[0].id;
            this.mapView = 'stars';
        },
        starSelected(e): void {
            this.starPosition.star = e.path[0].id;
            this.mapView = 'stars';
            this.GS_retrieveStarSystemType(this.starPosition)
                .then(() => this.UIM_setLocalStarPosition(this.starPosition))
                .then(() => this.$router.push('/planet'));
        }
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
.mapView {
    height: 90%;
    position: relative;
    overflow: hidden;

    .coordinates {
        position: absolute;
        height: 300px;
        width: auto;
        margin: 20px;
        background: #000208;
        color: var(--offset-white);
        border-radius: 20px;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: start;
        flex-direction: column;
        font-size: 19pt;
        bottom: 0;
    }
    .map {
        height: 100%;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    & .galaxy-svg {
        position: absolute;
        height: 90%;
        z-index: 0;
    }
    & .quadrant-map {
        & .quadrants {
            position: absolute;
            height: 90%;
            z-index: 1;
        }

        & .quadrants-highlights {
            position: absolute;
            height: 90%;
            z-index: 2;
            & path {
                visibility: hidden;
                fill: none;
                pointer-events: all;
            }

            & path:hover {
                visibility: visible;
                cursor: pointer;
            }
        }
    }

    & .sector-map {
        height: 100%;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        & .sectors {
            position: absolute;
            height: 90%;

            & path {
                fill: none;
                pointer-events: all;
            }

            & path:hover {
                visibility: visible;
                fill: white;
                cursor: pointer;
            }
        }
    }
    & .star-map {
        height: 100%;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        & .stars {
            position: absolute;
            height: 90%;

            & rect {
                fill: none;
                pointer-events: all;
            }

            & rect:hover {
                visibility: visible;
                fill: white;
                cursor: pointer;
            }
        }
    }
}
</style>
