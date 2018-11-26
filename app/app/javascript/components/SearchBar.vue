<template>
    <div class="columns is-mobile is-centered">
        <div class="column is-half is-narrow">
            <div class="field has-addons">
                <div class="control is-expanded">
                    <input class="input" v-model="query" type="text"
                           placeholder="Find food or Seller">
                </div>
                <div class="control">
                    <a class="button is-info">
                        Search
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    export default {
        name: "SearchBar",
        data: function () {
            return {
                query: ''
            }
        },
        watch: {
            query: function (val, old_val) {
                console.log(`Val was ${old_val}. Became ${val}`)
            }
        }
    }
</script>

<style scoped>

</style>