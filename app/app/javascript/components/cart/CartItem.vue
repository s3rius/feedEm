<template>
    <div class="card">
        <header class="card-header">
            <p class="card-header-title">
                {{item.name}}
            </p>
            <div class="card-header-icon">
                <b-icon icon="food-fork-drink"></b-icon>
            </div>
        </header>
        <div class="card-content">
            <div class="content">
                <ul>
                    <li>Seller: {{item.seller.name}}</li>
                    <li>Quantity: {{item.quantity}}</li>
                    <li>Cost: ${{item.price}}</li>
                </ul>
            </div>
        </div>
        <footer class="card-footer">
            <a @click="addToCart" class="card-footer-item">
                <b-icon icon="plus"></b-icon>
                Add more
            </a>
            <a @click="removeMerchandise" class="card-footer-item">
                <b-icon icon="minus"></b-icon>
                Remove one
            </a>
            <a :href="getLink()" class="card-footer-item">Open</a>
        </footer>
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        name: "f-cart-item",
        components: {BIcon},
        props: {
            item: {
                default: () => {
                }
            }
        }, methods: {
            getLink() {
                return `/merchandises/${this.item.id}`
            },
            removeMerchandise() {
                this.$events.emit('deleteMerchandise', this.item)
            },
            addToCart() {
                this.$events.emit('addMerchandiseToCart', this.item)
            }
        }
    }
</script>

<style scoped>

</style>