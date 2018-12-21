<template>
    <div class="card order">
        <header class="card-header">
            <p class="card-header-title badge" data-badge="pending" v-if="status === 'pending'">
                Order from {{this.order.seller_name}}
            </p>
            <p class="card-header-title badge is-badge-success" data-badge="open" v-else-if="for_seller">
                Pending order
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
                <p>Price: ${{price/100}}</p>
                <p>Will be ready {{time}}.</p>
            </div>
        </div>
        <footer class="card-footer" v-if="checkingout">
            <a @click="useOrder" class="card-footer-item">
                <b-icon icon="check"></b-icon>
                Chekout this order
            </a>
        </footer>
        <footer class="card-footer" v-else-if="for_seller">
            <a @click="sellerReject" class="card-footer-item">
                <b-icon icon="close-circle"></b-icon>
                Reject this order
            </a>
            <a @click="sellerReady" class="card-footer-item">
                <b-icon icon="check"></b-icon>
                order is ready
            </a>
        </footer>
        <footer class="card-footer" v-else>
            <a @click="userReject" class="card-footer-item">
                <b-icon icon="close-circle"></b-icon>
                Reject this order.
            </a>
        </footer>
    </div>
</template>

<script>
    import CardPicker from '../cart/OrderCardPicker'
    import moment from 'moment'
    export default {
        name: "OrderItem",
        data(){
            return{
                price: 0,
                time: ""
            }
        },
        props: {
            status:{
                default: "pending"
            },
            for_seller:{
                default: false
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
                console.log(moment.locale());
                this.price = 0;
                this.time = moment(this.order.time).calendar().toLowerCase();
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
            },
            sellerReject(){

            },userReject(){

            },sellerReady(){

            }
        }
    }
</script>

<style scoped>
    .order{
        margin-bottom: 20px;
    }
</style>