<template>
    <form action="/cards" method="post">
        <input name="utf8" type="hidden" value="✓">
        <input type="hidden" name="authenticity_token" :value="get_token()">
        <b-field v-if="this.customerId == null">
            <b-input placeholder="Customer id"
                     name="card[customer_id]"
                     icon="user"
                     reqired>
            </b-input>
        </b-field>
        <input type="hidden"
               name="card[customer_id]"
               :value="this.customerId" v-else>
        <b-field>
            <b-input placeholder="Credit card number"
                     maxlength="16"
                     name="card[number]"
                     pattern="[0-9]{16,16}"
                     v-model="card_number"
                     icon="credit-card"
                     reqired>
            </b-input>
        </b-field>
        <b-field>
            <b-input maxlength="3"
                     icon="lock"
                     v-model="cvv"
                     pattern="[0-9]{3,3}"
                     name="card[cvv]"
                     placeholder="CVV"
                     reqired>
            </b-input>
        </b-field>
        <b-field>
            <b-datepicker
                    placeholder="Expire date"
                    v-model="expire"
                    name="card[expire]"
                    icon="calendar-today"
                    reqired>
            </b-datepicker>
        </b-field>
        <b-field>
            <input type="submit" name="commit"
                   class="button is-primary is-fullwidth"
                   value="Add card"
                   data-disable-with="Add card">
        </b-field>
    </form>
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
            },
            token: {
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
            get_token(event) {
                return window.token;
            }
        }
    }
</script>

<style scoped>

</style>
