<template>
    <div class="modal-card" style="width: auto">
        <header class="modal-card-head">
            <p class="modal-card-title">Choose card</p>
        </header>
        <section class="modal-card-body">
            <div class="container">
                <div class="columns is-multiline is-mobile is-fullwidth">
                    <div class="column is-12-mobile is-mobile" :class="itemClass" v-for="card of this.cards">
                        <f-credit-card :order="order" :card="card"></f-credit-card>
                    </div>
                    <div class="column is-12-mobile is-mobile has-text-centered is-vertical-center">
                        <a class="button is-fullwidth" :href="`/customers/${user.id}`">
                            <b-icon icon="credit-card-plus" href="/cards/new"></b-icon>
                            <p>Add card in profile</p>
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <footer class="modal-card-foot">
            <button class="button" type="button" @click="$parent.close()">Close</button>
        </footer>
    </div>
</template>

<script>
    export default {
        name: "OrderCardPicker",
        props: {
            order: {
                default: () => {
                }
            },
            user: {
                default: () => {
                }
            }
        }, data() {
            return {
                cards: [],
                itemClass: {}
            }
        },
        mounted() {
            let component = this;
            let card_picker = this.axios.create({
                headers: {
                    'X-Requested-With': 'XMLHttpRequest',
                    "X-CSRF-Token": window.token,
                    'Content-Type': 'application/json',
                    'Accept': 'application/json'
                }
            });
            this.$events.listen('cardUsed', eventData=>{
                this.$parent.close();
            });
            card_picker.get('/api/v1/getMyCards').then((response) => {
                for (var card in response.data.cards){
                    console.log(response.data.cards[card])
                    this.cards.push(response.data.cards[card])
                }
            }).catch((error) => {
                this.$snackbar.open({
                    message: "Can't get your cards.",
                    type: "is-danger",
                    position: 'is-bottom-left'
                });
                console.log(error);
            });
            this.itemClass = {
                'is-6-desktop': this.cards.length > 1,
                'is-12-desktop': this.cards.length === 1
            };
        }
    }
</script>

<style scoped lang="scss">
    .container{
        width: 100%;
    }
    .new_card{
        width: 100%;
    }
    .is-vertical-center {
        display: flex;
        align-items: center;
        -webkit-box-align: center;
        -ms-flex-align: center;
        align-items: center;
    }
</style>