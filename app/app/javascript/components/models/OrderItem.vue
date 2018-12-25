<template>
    <div class="card order">
        <header class="card-header">
            <p class="card-header-title badge" :data-badge="status" :class="styleClass" v-if="status === 'pending'">
                Order from {{this.order.seller_name}}
            </p>
            <p class="card-header-title badge " :data-badge="status" :class="styleClass" v-else-if="for_seller">
                Pending order
            </p>
            <p  class="card-header-title badge " :data-badge="status" :class="styleClass" v-else>
                Order from &nbsp;<a :href="`/sellers/${this.order.seller_id}`"> {{this.order.seller_name}}</a>
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
                <p v-if="for_seller">Must be ready {{time}}.</p>
                <p v-else>Will be ready {{time}}.</p>
            </div>
        </div>
        <footer class="card-footer" v-if="checkingout">
            <a @click="useOrder" class="card-footer-item">
                <b-icon icon="check"></b-icon>
                Chekout this order
            </a>
        </footer>
        <footer class="card-footer" v-else-if="for_seller && status === 'open'">
            <a @click="orderReject" class="card-footer-item">
                <b-icon icon="close-circle"></b-icon>
                Reject this order
            </a>
            <a @click="sellerReady" class="card-footer-item">
                <b-icon icon="check"></b-icon>
                order is ready
            </a>
        </footer>
        <footer class="card-footer" v-else-if="!for_seller && status === 'open'">
            <a @click="orderReject" class="card-footer-item">
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
                time: "",
                req_data: {
                    orderId: -1
                },
                styleClass:{}
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
                this.req_data.orderId = this.order.order_id;
                this.styleClass={
                    'is-badge-success' : !(this.status === 'open'),
                    'is-badge-warning' : this.status === 'open'
                }
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
            orderReject(){
                let axi_reject = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": window.token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                var component = this;
                axi_reject.post("/api/v1/closeOrder", this.req_data).then((response) => {
                    console.log("Order was rejected");
                    location.reload();
                }).catch((error) => {
                    component.$snackbar.open({
                        message: "Can't reject order.",
                        type: "is-danger",
                        position: 'is-bottom-left'
                    });
                    console.log(error);
                });
            },sellerReady(){
                let axi_ready = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": window.token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                var component = this;
                axi_ready.post("/api/v1/readyOrder", this.req_data).then((response) => {
                    console.log("Order was marked as ready");
                    location.reload();
                }).catch((error) => {
                    component.$snackbar.open({
                        message: "Can't mark order as ready",
                        type: "is-danger",
                        position: 'is-bottom-left'
                    });
                    console.log(error);
                });
            }
        }
    }
</script>

<style scoped>
    .order{
        margin-bottom: 20px;
    }
</style>