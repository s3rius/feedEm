<template>
    <div>
        <b-icon class="is-inline-block" v-if="item.type === 'Seller'"
                icon="store"></b-icon>
        <b-icon class="is-inline-block" v-if="item.type === 'Order item'"
                icon="food-fork-drink"></b-icon>
        <div class="is-inline-block">{{ item.suggest }}</div>
        <div class="is-inline-block" v-if="item.type === 'Order item'">
            by <a :href="item.seller_url">{{ item.seller }}</a>
        </div>
        <div class="is-inline-block f-right"
             v-if="item.type === 'Seller'">
            <a class="button search-button" :href="item.url">
                Open page
            </a>
        </div>
    </div>
</template>

<script>
    export default {
        props: {
            item: {required: true}
        }
    }
</script>

<style scoped lang="scss">
    .searchItem {
        background-color: #fff;
    }

</style>