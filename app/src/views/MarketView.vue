<template>
    <div class="Market">
        <h2>{{ UIM_RecentError.message }}</h2>
    </div>
</template>

<script lang="ts">
// @ is an alias to /src
import { mapGetters } from 'vuex';

export default {
    name: 'MarketView',
    computed: {
        ...mapGetters(['UIM_RecentError'])
    }
};
</script>
