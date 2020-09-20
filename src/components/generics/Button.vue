<template>
    <button class="button" :class="buttonStyle" @click="submit">
        {{ title }}
    </button>
</template>

<script>
export default {
    name: 'Button',
    props: ['title', 'buttonStyle'],
    methods: {
        submit: function() {
            this.$emit('clicked');
        }
    }
};
</script>

<style scoped lang="scss">
.button {
    margin: 25px 0;
    border: none;
    padding: 15px;

    &:hover {
        cursor: pointer;
    }
}

.danger {
    background: #f43;
    color: white;
}

.primary {
    background: #2edbcd;
    color: white;
}
</style>
