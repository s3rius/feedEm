<template>
    <div>
        <button class="button is-primary" data-show="quickview" data-target="quickviewCart">
            <b-icon icon="cart" class="badge" :data-badge="item_count"></b-icon>
            <span>Cart</span>
        </button>
        <div id="quickviewCart" class="quickview">
            <header class="quickview-header">
                <p class="title">My cart</p>
                <span class="delete" data-dismiss="quickview"></span>
            </header>

            <div class="quickview-body">
                <div class="quickview-block">
                    ...
                </div>
            </div>

            <footer class="quickview-footer">
                <div class="buttons">
                    <a class="button is-primary" @click="checkout">
                        Checkout
                    </a>
                    <a class="button is-primary" @click="clear">
                        <strong>Clear</strong>
                    </a>
                </div>
            </footer>
        </div>
    </div>
</template>

<script>
    import 'bulma-extensions/bulma-quickview/dist/css/bulma-quickview.min.css'
    import bulmaQuickview from 'bulma-extensions/bulma-quickview/dist/js/bulma-quickview.js'
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        name: "Cart",
        components: {BIcon},
        data: function () {
            return {
                item_count: 0,
                sellers: {}
            }
        },
        props: {
            user: {
                default: () => null
            }
        },
        mounted() {
            this.item_count = sessionStorage.length;
            var quickviews = bulmaQuickview.attach();
            this.$events.listen('addMerchandiseToCart', eventData => {
                let seller = sessionStorage.getItem(eventData.seller.id);
                let new_item = {
                    id: eventData.id,
                    name: eventData.name,
                    quantity: 1
                };
                if (seller != null) {
                    let new_seller = JSON.parse(seller);
                    if (new_seller[eventData.id] == undefined) {
                        new_seller[eventData.id] = new_item;
                        this.sellers[eventData.seller.id] = new_item;
                        sessionStorage.setItem(eventData.seller.id, new_item);
                    } else {
                        let old_item = new_seller[eventData.id];
                        old_item.quantity += 1;
                        this.sellers[eventData.seller.id] = old_item;
                        sessionStorage.setItem(eventData.seller.id, old_item);
                    }
                } else {
                    let new_data = {};
                    new_data[eventData.id] = {
                        id: eventData.id,
                        name: eventData.name,
                        quantity: 1
                    };
                    this.sellers[eventData.seller.id] = new_data
                    sessionStorage.setItem(eventData.seller.id, new_data);
                }
                sessionStorage.setItem(eventData.id, JSON.stringify(new_item));
                this.item_count = sessionStorage.length;
            });
        },
        methods: {
            checkout(event) {
                console.log("Fuck me")
            },
            clear(event) {
                console.log("Cleared")
            }
        }
    }
</script>
<style scoped>

</style>