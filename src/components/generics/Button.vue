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
    background: rgb(239, 239, 239);
    margin: 0 5px;
    &:hover {
        background: darken(rgb(239, 239, 239), 10%);
        cursor: pointer;
    }
}

.danger {
    background: #f43;
    color: white;
    &:hover {
        background: darken(#f43, 33%);
    }
}

.primary {
    background: #2edbcd;
    color: white;
    &:hover {
        background: darken(#2edbcd, 10%);
    }
}
</style>
