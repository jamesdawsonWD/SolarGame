<template>
    <div class="Planet">
        <div
            class="undiscovered"
            v-if="systemTypes[GS_getStarPositionType(UIM_getLocalStarPosition)] == systemTypes[0]"
        >
            <h1>Undiscovered System</h1>
            <Button
                title="Explore"
                @clicked="GO_move(UIM_getLocalStarPosition)"
                buttonStyle="primary"
            ></Button>
        </div>
    </div>
</template>

<script lang="ts">
import { mapActions } from 'vuex';
import { mapGetters } from 'vuex';
import Button from '@/components/generics/Button.vue';
export default {
    name: 'PlanetView',
    computed: {
        ...mapGetters(['GS_getStarPositionType', 'UIM_getLocalStarPosition'])
    },
    components: {
        Button
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
