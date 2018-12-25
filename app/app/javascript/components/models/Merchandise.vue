<template>
    <div class="card">
        <header class="card-header">
            <p class="card-header-title">
                {{merchandise.name}}
            </p>
            <div class="card-header-icon">
                <b-icon icon="food-fork-drink"></b-icon>
            </div>
        </header>
        <div class="card-content">
            <div class="content">
                {{merchandise.description}}
                <br>
                <span>Made by: <a :href="`/sellers/${merchandise.seller.id}`">{{merchandise.seller.name}}</a></span>
                <br>
                <span>Cost: ${{merchandise.price/100}}</span>
            </div>
        </div>
        <footer class="card-footer">
            <a @click="addToCart" class="card-footer-item">
                <b-icon icon="cart-plus"></b-icon>
                Add to cart</a>
            <a :href="getLink()" class="card-footer-item">Open</a>
        </footer>
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        name: "merchandise",
        components: {BIcon},
        props: {
            merchandise: {
                default: function () {
                    return {}
                }
            }
        },
        methods: {
            getLink: function () {
                return `/merchandises/${this.merchandise.id}`
            },
            addToCart: function () {
                this.$events.emit('addMerchandiseToCart', this.merchandise)
            }
        }
    }
</script>

<style scoped>

</style>