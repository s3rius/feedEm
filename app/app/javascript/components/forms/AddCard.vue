<template>
    <b-field class="is-grouped">
        <b-input placeholder="Credit card number"
                 maxlength="16"
                 v-model="card_number"
                 icon="credit-card">
        </b-input>
        <b-input maxlength="3"
                 icon="lock"
                 v-model="cvv"
                 placeholder="CVV">
        </b-input>
        <b-datepicker
                placeholder="Expire date"
                v-model="expire"
                icon="calendar-today">
        </b-datepicker>
        <a class="button" @click="card_completed">Add card</a>
    </b-field>
</template>

<script>

    import BInput from "buefy/src/components/input/Input";
    import BField from "buefy/src/components/field/Field";

    export default {
        name: "AddCard",
        components: {BInput, BField},
        props: {
            customerId: {
                default: null
            }
        },
        data: function () {
            return {
                card_number: null,
                cvv: null,
                expire: null
            }
        }, methods: {
            card_completed(event) {
                console.log(this.card_number);
                console.log(this.cvv);
                console.log(this.expire);
            }
        }
    }
</script>

<style scoped>

</style>