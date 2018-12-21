<template>
    <div>
        <button class="button is-primary" data-show="quickview" data-target="quickviewCart">
            <b-icon icon="cart" class="badge" :data-badge="item_count"></b-icon>
            <span>Cart</span>
        </button>
        <div id="quickviewCart" class="quickview">
            <header class="quickview-header">
                <p class="title">My cart</p>
                <p>Total: ${{this.total/100}}</p>
                <span class="delete" data-dismiss="quickview"></span>
            </header>

            <div class="quickview-body">
                <div class="quickview-block">
                    <div v-for="item of items">
                        <f-cart-item :item="item"></f-cart-item>
                    </div>
                </div>
            </div>

            <footer class="quickview-footer">
                <div class="buttons">
                    <a class="button is-primary" @click="checkout">
                        <b-icon icon="check"></b-icon>
                        Checkout
                    </a>
                    <a class="button is-primary" @click="clear">
                        <b-icon icon="cart-off"></b-icon>
                        <strong>Clear cart</strong>
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
    import CartItem from './CartItem'
    import CheckoutModal from './CheckoutModal'

    export default {
        name: "Cart",
        components: {
            'b-icon': BIcon,
            'f-cart-item': CartItem
        },
        data: function () {
            return {
                total: 0,
                item_count: 0,
                items: []
            }
        },
        props: {
            user: {
                default: () => null
            }
        },
        mounted() {
            this.item_count = localStorage.length;
            var quickviews = bulmaQuickview.attach();
            let component = this;
            this.total = 0;
            Object.keys(localStorage).forEach(function (key) {
                let item = JSON.parse(localStorage.getItem(key))
                component.items.push(item);
                component.total += item.price * item.quantity;
            });


            this.$events.listen('cardUsed', eventData=>{
                component.total = 0;
                let indeces = eventData.order.items.map( merch => merch.id);
                component.items = component.items.filter(function (item) {
                    return indeces.indexOf(item.id) == -1
                })
                this.save_all();
                // localStorage.clear()
                // for (var index in component.items){
                //     let item = component.items[index];
                //     component.total += item.price * item.quantity;
                // } 
                // component.item_count = component.items.length;
            });


            this.$events.listen('addMerchandiseToCart', eventData => {
                let item = JSON.parse(localStorage.getItem(eventData.id));
                this.total += eventData.price;
                if (item === null) {
                    eventData.quantity = 1;
                    this.items.push(eventData);
                    localStorage.setItem(eventData.id, JSON.stringify(eventData));
                } else {
                    let index = -1;
                    for (let i = 0; i < this.items.length; i++) {
                        if (this.items[i].id === item.id) {
                            index = i;
                        }
                    }
                    item.quantity += 1;
                    this.$set(this.items, index, item);
                    localStorage.setItem(eventData.id, JSON.stringify(item));
                }
                this.item_count = localStorage.length;
            });


            this.$events.listen('deleteMerchandise', eventData => {
                let item = JSON.parse(localStorage.getItem(eventData.id));
                let index = -1;
                for (let i = 0; i < this.items.length; i++) {
                    if (this.items[i].id === item.id) {
                        index = i;
                    }
                }
                this.total -= item.price;
                item.quantity -= 1;
                if (item.quantity < 1) {
                    this.items.splice(index, 1);
                    localStorage.removeItem(eventData.id);
                    this.item_count -= 1;
                } else {
                    this.$set(this.items, index, item);
                    localStorage.setItem(eventData.id, JSON.stringify(item));
                }
            });
        },
        methods: {
            checkout(event) {
                if (this.items.length == 0) {
                    this.$snackbar.open({
                        message: "Nothing to checkout.",
                        type: "is-danger",
                        position: 'is-bottom-left'
                    });
                }else{
                    if (this.user === null) {
                        this.$snackbar.open({
                            message: "You're not logged in",
                            type: "is-danger",
                            position: 'is-bottom-left'
                        });
                    } else {
                        this.$modal.open({
                            parent: this,
                            component: CheckoutModal,
                            props: {
                                items: this.items,
                                user: this.user
                            },
                            hasModalCard: true
                        });
                    }
                }
            },
            clear(event) {
                this.total = 0;
                this.items.splice(0);
                this.item_count = 0;
                localStorage.clear();
                console.log("Cart was cleared.")
            },
            save_all(){
                this.total = 0;
                localStorage.clear();
                for (var index in this.items){
                    let item = this.items[index];
                    this.total += item.price * item.quantity;
                    localStorage.setItem(item.id, JSON.stringify(item));
                }
                this.item_count = this.items.length;
            }
        }
    }
</script>
<style scoped>

</style>