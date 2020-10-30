<template>
    <div class="Planet">
        <div
            class="undiscovered"
            v-if="systemTypes[GS_getStarPositionType(UIM_getLocalStarPosition)] == systemTypes[0]"
        >
            <Planet1 class="svg" />
            <div class="info">
                <h1>Undiscovered System</h1>
                <div>
                    <h2>Who knows what there is to be found?</h2>

                    <Button
                        title="Explore"
                        @clicked="GO_move(UIM_getLocalStarPosition)"
                        buttonStyle="primary"
                    ></Button>
                </div>
            </div>
        </div>
        <div class="undiscovered" v-else>
            <Galaxy />
            <div class="info">
                <div>
                    <h1>{{ UIM_getPlanetDiscoveredHeader }}</h1>
                </div>
                <h2>{{ UIM_getPlanetDiscoveredMessage }}</h2>
            </div>
        </div>
    </div>
</template>

<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Button from '@/components/generics/Button.vue';
import Planet1 from '@/assets/svg/planet1.svg';
import Galaxy from '@/assets/svg/galaxy.svg';

export default {
    name: 'PlanetView',
    computed: {
        ...mapGetters([
            'GS_getStarPositionType',
            'UIM_getLocalStarPosition',
            'UIM_getPlanetDiscoveredHeader',
            'UIM_getPlanetDiscoveredMessage'
        ])
    },
    components: {
        Button,
        Planet1,
        Galaxy
    },
    methods: {
        ...mapActions(['GO_move'])
    },

    data(): void {
        return {
            systemTypes: this.$utils.SYSTEM_TYPES_IDS
        };
    }
};
</script>
<style lang="scss">
#app {
    overflow-x: hidden;
}
.Planet {
    height: 80vh;
    width: 100vw;

    & > div {
        height: 100%;
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        position: relative;

        .svg {
            position: absolute;
            height: 90%;
            z-index: 0;
        }

        .question-mark {
            left: 0;
            bottom: 0;
            right: 0;
            top: 0;
            margin: auto;
        }

        .info {
            height: 100%;
            position: absolute;
            z-index: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            align-items: center;
        }
        h1 {
        }
    }
}
</style>
