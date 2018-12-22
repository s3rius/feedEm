<template>
    <div class="card" :class="{'is-hidden': this.hidden}">
        <header class="card-header">
            <p class="card-header-title">
                Card
            </p>
            <div class="card-header-icon">
                <b-icon icon="credit-card"></b-icon>
            </div>
        </header>
        <div class="card-content">
            <div class="content has-text-centered">
                ****-****-****-{{this.card.card}}
                <br>
            </div>
        </div>
        <footer class="card-footer" v-if="this.order !== null">
            <a @click="useCard" class="card-footer-item">
                <b-icon icon="check"></b-icon>
                Use card</a>
        </footer>
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        name: "CreditCard",
        components: {BIcon},
        props: {
            order: {
                default: () => null
            },
            card: {
                default: function () {
                    return {}
                }
            },
        },
        data: function () {
            return {
                hidden: false
            }
        },
        methods: {
            removeCard() {
                let component = this;
                let axi_delete = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": window.token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                axi_delete.delete(`/cards/${this.card.id}`)
                    .then(response => {
                        console.log(response);
                        component.hidden = true;
                        component.$snackbar.open({
                            message: "Card deleted successfully",
                            type: "is-success",
                            position: 'is-bottom-left'
                        });
                    }).catch(error => {
                        console.log(error);
                        component.$snackbar.open({
                            message: "Can't delete card",
                            type: "is-danger",
                            position: 'is-bottom-left'
                        });
                    });
            },
            getLink() {
                return `/cards/${this.card.id}`
            },
            useCard(){
                let component = this;
                let event_data = {
                    card: this.card.id,
                    order: this.order
                }
                let token = window.token;
                let axi_pay = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                axi_pay.post('/api/v1/addOrder',event_data).
                    then(response => {
                        console.log(response);
                        component.$events.emit('cardUsed', event_data );
                    }).catch(error => {
                        console.log(error);
                        component.$snackbar.open({
                            message: "Can't process order",
                            type: "is-danger",
                            position: 'is-bottom-left'
                        });
                    })
            }
        }
    }
</script>

<style scoped>
    .is-hidden {
        display: none;
    }

    .card {
        margin-top: 10px;
    }
</style>