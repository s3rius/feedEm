<template>
    <div class="columns is-mobile is-centered">
        <div class="column is-narrow" :class="{'is-half': this.is_half}" ref="bar">
            <div class="field has-addons">
                <div class="control is-expanded">
                    <!--<input class="input" v-model.trim="query" type="text"-->
                    <!--placeholder="Find food or Seller">-->
                    <vue-simple-suggest
                            :max-suggestions="10"
                            :list="updateItems"
                            :value-attribute="value_attr"
                            :display-attribute="display_attr"
                            :styles="autoCompleteStyle"
                            :destyled=true
                            ref="suggestComponent"
                    >
                        <b-input placeholder="Find food or Seller"></b-input>

                        <div class="search-item" slot="suggestion-item" slot-scope="{ suggestion, query }">
                            <s-item :item="suggestion"></s-item>
                        </div>
                    </vue-simple-suggest>
                </div>
                <div class="control">
                    <a class="button is-info" @click="searchForIt">
                        <b-icon icon="magnify" type="is-white"></b-icon>
                    </a>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";
    import SearchItem from './ItemTemplate'

    const VueSimpleSuggest = require('vue-simple-suggest/dist/cjs');
    import BInput from "buefy/src/components/input/Input";

    export default {
        name: "SearchBar",
        components: {
            'b-input': BInput,
            's-item': SearchItem,
            'vue-simple-suggest': VueSimpleSuggest,
            'b-icon': BIcon
        },
        props: {
            is_half: {
                default: false
            }
        },
        data: function () {
            return {
                autoCompleteStyle: {
                    vueSimpleSuggest: "position-relative",
                    inputWrapper: "",
                    defaultInput: "form-control",
                    suggestions: "position-absolute list-group z-1000",
                    suggestItem: "list-group-item"
                },
                value_attr: 'url',
                display_attr: 'suggest'
            }
        },
        methods: {
            updateItems(text) {
                return this.axios.get(`/search_api/search?query=${text}&limit=5`)
                    .then((response) => {
                        return response.data.data
                    });
            },
            searchForIt() {
                let query = this.$refs.suggestComponent.text;
                if (query === undefined || query.trim() === '') {
                    this.$snackbar.open({
                        message: `Empty query`,
                        type: 'is-warning',
                        position: 'is-bottom-left'
                    });
                } else {
                    Turbolinks.visit(`/search/search?query=${query}`);
                }
            }
        }
    }
</script>

<style lang="scss">
    $mcolor: #7957D5;

    @media screen and (max-width: 900px) {
        .column.is-narrow.is-half {
            width: 100% !important;
        }
    }

    .search-button {
        line-height: 1;
        border-radius: 10px;
        border: 2px solid $mcolor;
        width: 100%;
        height: 100%;
    }

    .f-right {
        float: right;
    }

    .position-absolute {
        position: absolute !important;
    }

    .z-1000 {
        z-index: 1000;
    }

    .suggest-item {
        overflow: auto;
        background: #ffffff;
    }

    .list-group {
        width: 100%;
        border-radius: 0 0 20px 20px;
    }

    .v-autocomplete-input {
        box-shadow: none;
        border: 1px solid $mcolor;
        width: 100%;
    }

    .hover {
        background-color: $mcolor;
        color: #fff;
    }

    .suggestions {
        opacity: 1;
    }

    .vue-simple-suggest-enter-active.suggestions,
    .vue-simple-suggest-leave-active.suggestions {
        /* Transition length here:*/
        transition: opacity .2s;
    }

    .vue-simple-suggest-enter.suggestions,
    .vue-simple-suggest-leave-to.suggestions {
        /* Transition rule for "disengaged" element:*/
        opacity: 0;
    }
</style>