<template>
    <div>
        I'm order. Fuck you.
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        components: {BIcon},
        name: "Order",
        methods: {
            getLink() {
                return `/cards/${this.card.id}`
            }
        }
    }
</script>

<style scoped>

</style>