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
                <span>Made by: {{merchandise.seller.name}} with <b-icon icon="heart"></b-icon></span>
                <br>
                <span>Cost: ${{merchandise.price}}</span>
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
            merchandise: () => {
            }
        },
        methods: {
            getLink: function () {
                return `/merchandises/${this.merchandise.id}`
            },
            addToCart: function () {
                let params = new URLSearchParams();
                params.append('merch_id', this.merchandise.id);
                this.axios.post('/api/v1/addToCart', params)
                    .then(function (response) {
                            this.$snackbar.open({
                                message: `Error found: Can't add merchandise.`,
                                type: 'is-error',
                                position: 'is-bottom-left'
                            });
                        }
                    )
                    .catch(function (err) {
                            console.error(err);
                            this.$snackbar.open({
                                message: `Error found: Can't add merchandise.`,
                                type: 'is-error',
                                position: 'is-bottom-left'
                            });
                        }
                    )
            }
        }
    }
</script>

<style scoped>

</style>