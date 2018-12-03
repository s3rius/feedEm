<template>
    <div>
        <section class="hero is-medium" v-bind:style="{ 'background-image': 'url(' + image + ')' }">
            <div class="hero-head">
                <f-navbar :visible_search="visible"></f-navbar>
            </div>
            <div class="hero-body has-text-centered">
                <f-search class="s-bar" :is_half="true" v-observe-visibility="searchBarObserver">
                </f-search>
            </div>
            <div class="hero-foot">
                <nav class="tabs is-boxed is-fullwidth">
                    <div class="container">
                        <ul>
                            <li :class="{'is-active': activeTab(0)}">
                                <a :class="{'has-text-white': !activeTab(0)}">Available merchandises</a>
                            </li>
                            <li :class="{'is-active': activeTab(1)}">
                                <a :class="{'has-text-white': !activeTab(1)}">Sellers</a>
                            </li>
                        </ul>
                    </div>
                </nav>
            </div>
        </section>
        <section id="tabs">
            <slot></slot>
        </section>
    </div>
</template>

<script>
    import FeedemSearch from "./searchbar/SearchBar";

    export default {
        name: "TitleWelcome",
        components: {
            'f-search': FeedemSearch
        },
        props: {
            tabIndex: {
                default: 0
            }
        },
        data: function () {
            return {
                image: "img/sushi.jpg",
                visible: false,
            }
        },
        methods: {
            searchBarObserver(isVisible, entry) {
                this.visible = !isVisible;
            },
            activeTab: function (index) {
                console.log(`loaded index=${index}.\nLoaded tabIndex=${this.tabIndex}`);
                return this.tabIndex === index
            }
        }
    }
</script>

<style scoped lang="scss">
    $mcolor: #7957D5;

    .button.icon:first-child:last-child {
        margin-left: 0;
        margin-right: 0;
    }

    .hero {
        background-size: cover;
        background-position: center;
    }

    .s-bar {
        position: relative;
    }

    .has-text-white:hover {
        color: $mcolor;
    }
</style>