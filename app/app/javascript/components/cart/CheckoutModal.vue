<template>
    <div class="modal-card" style="width: auto">
        <header class="modal-card-head">
            <p class="modal-card-title">Chekout </p>
        </header>
        <section class="modal-card-body">
            <div class="container">
                <div class="columns is-multiline is-mobile is-fullwidth">
                    <div class="column is-12-mobile is-mobile" :class="" v-for="order of this.orders">
                        <f-order-item 
                            :order="order"
                            :checkingout="true" 
                            :user="user">
                             
                         </f-order-item>
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
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        name: "CheckoutModal",
        components: {
            'b-icon': BIcon
        },
        props: {
            items: {
                default: () => []
            },
            user: {
                default: () => {
                }
            }
        },
        data() {
            return {
                orders: [],
                itemClass: {}
            }
        },
        mounted() {
            let component = this;
            this.$events.listen('cardUsed', eventData=>{
                let used_id = eventData.order.seller_id;
                component.orders = component.orders.filter(item=>{
                    return item.seller_id != eventData.order.seller_id
                });
                if (component.orders.length < 1){
                    component.$parent.close();
                }
            });
            let new_orders = {};
            for (var index = 0; index < this.items.length; index++) {
                let item = this.items[index];
                if (new_orders[item.seller.id] === undefined) {
                    new_orders[item.seller.id] = [item];
                } else {
                    new_orders[item.seller.id].push(item)
                }
            }
            Object.keys(new_orders).forEach(function (key) {
                component.orders.push({
                    seller_id: key,
                    seller_name: new_orders[key][0].seller.name,
                    items: new_orders[key]
                });
            });
            this.itemClass = {
                'is-6-desktop': this.orders.length > 1,
                'is-12-desktop': this.orders.length === 1
            };
        }
    }
</script>

<style scoped>
    .container {
        width: 100%;
    }
</style>