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
    data() {
        return {
            formSubmitted: false
        };
    },
    methods: {
        ...mapActions([
            'setAllowance',
            'increaseAllowance',
            'setError',
            'closeModal'
        ]),
        submit: async function() {
            if (!this.formSubmitted) {
                this.formSubmitted = true;
                try {
                    await this.setAllowance(this.amount);
                    await this.closeModal();
                    this.formSubmitted = false;
                } catch {
                    err => this.setError(err);
                    this.formSubmitted = false;
                }
            }
        }
    }
})
export default class AllowanceForm extends Vue {
    @Prop() private amount!: number;
}
</script>
