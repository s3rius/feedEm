<template>
    <div class="columns is-mobile is-centered">
        <div class="column is-narrow" :class="{'is-half': this.is_half}" ref="bar">
            <resize-observer @notify="handleBarResize"/>
            <div class="field has-addons">
                <div class="control is-expanded">
                    <input class="input" v-model.trim="query" type="text"
                           placeholder="Find food or Seller">
                </div>
                <div class="control">
                    <a class="button is-info">
                        <b-icon icon="magnify" type="is-white"></b-icon>
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        name: "SearchBar",
        components: {BIcon},
        props: {
            is_half: {
                default: false
            }
        },
        data: function () {
            return {
                query: '',
            }
        },
        watch: {
            query: function (val, old_val) {
                console.log(`Val was ${old_val}. Became ${val}`)
            }
        },
        methods: {
            handleBarResize: function () {
                console.log(this.$refs.bar.clientWidth);
            }
        }
    }
</script>

<style scoped lang="css">
    @media screen and (max-width: 900px) {
        .column.is-narrow.is-half {
            width: 100% !important;
        }
    }
</style>