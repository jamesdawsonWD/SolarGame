<template>
    <form @submit="submit">
        <h4>
            We do not have permission to send
            {{ amount ? amount : 'that much' }} Tsuno on your behalf.
        </h4>
        <Button title="Grant Permission" @clicked="submit" buttonStyle="primary"></Button>
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
    data() {
        return {
            formSubmitted: false
        };
    },
    methods: {
        ...mapActions(['setAllowance', 'increaseAllowance', 'setError', 'closeModal']),
        submit: async function() {
            if (!this.$data.formSubmitted) {
                this.$data.formSubmitted = true;
                try {
                    await this.$action.setAllowance(this.amount);
                    await this.closeModal();
                    this.$data.formSubmitted = false;
                } catch {
                    err => this.setError(err);
                    this.$data.formSubmitted = false;
                }
            }
        }
    }
})
export default class AllowanceForm extends Vue {
    @Prop() private amount!: number;
}
</script>
