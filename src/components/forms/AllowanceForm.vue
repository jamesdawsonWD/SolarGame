<template>
    <form @submit="submit">
        <h4>
            We do not have permission to send
            {{ amount ? amount : 'that much' }} Tsuno on your behalf.
        </h4>
        <Button
            title="Grant Permission"
            @clicked="submit"
            buttonStyle="primary"
        ></Button>
    </form>
</template>

<script lang="ts">
import { Component, Prop, Vue } from 'vue-property-decorator';
import { mapActions } from 'vuex';
import Button from '@/components/generics/Button.vue';
@Component({
    components: {
        Button
    },
    methods: {
        ...mapActions([
            'setAllowance',
            'increaseAllowance',
            'setError',
            'closeModal'
        ]),
        submit: async function() {
            this.setAllowance(this.amount)
                .then(() => {
                    this.closeModal();
                })
                .catch(err => this.setError(err));
        }
    }
})
export default class AllowanceForm extends Vue {
    @Prop() private amount!: number;
}
</script>
