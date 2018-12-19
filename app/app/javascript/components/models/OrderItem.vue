<template>
    <div class="card">
        <header class="card-header">
            <p class="card-header-title badge" data-badge="pending" v-if="status === 'pending'">
                Order from {{this.order.seller_name}}
            </p>
            <p class="card-header-title badge is-badge-warning" data-badge="open" v-else-if="status === 'open'">
                Order from {{this.order.seller_name}}
            </p>
            <p class="card-header-title badge is-badge-success" data-badge="ready" v-else>
                Order from {{this.order.seller_name}}
            </p>
            <div class="card-header-icon">
                <b-icon icon="playlist-check"></b-icon>
            </div>
        </header>
        <div class="card-content">
            <div class="content">
                <ul>
                    <li v-for="item of this.order.items">
                        {{item.name}}
                    </li>
                </ul>
                <p>Price: ${{price}}</p>
            </div>
        </div>
        <footer class="card-footer" v-if="checkingout">
            <a @click="useOrder" class="card-footer-item">
                <b-icon icon="check"></b-icon>
                Chekout this order
            </a>
        </footer>
    </div>
</template>

<script>
    import CardPicker from '../cart/OrderCardPicker'

    export default {
        name: "OrderItem",
        data(){
            return{
                price: 0
            }
        },
        props: {
            status:{
                default: "pending"
            },
            order: {
                default: () => {
                }
            },
            user: {
                default: () => {}
            },
            checkingout:{
                default: false
            }
        },mounted(){
                this.price = 0;
                for (var index in this.order.items){
                    let item = this.order.items[index];
                    this.price += item.price * item.quantity;
                }
        },
         methods: {
            useOrder() {
                this.$modal.open({
                    parent: this,
                    component: CardPicker,
                    props: {
                        order: this.order,
                        user: this.user
                    },
                    hasModalCard: true
                });
            }
        }
    }
</script>

<style scoped>

</style>