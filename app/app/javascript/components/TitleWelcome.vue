<template>
    <div>
        <section class="hero is-medium" v-bind:style="{ 'background-image': 'url(' + image + ')' }">
            <div class="hero-body has-text-centered">
                <f-search class="s-bar" :is_half="true" v-observe-visibility="searchBarObserver">
                </f-search>
            </div>
        </section>
        <section id="tabs">
            <b-tabs  position="is-centered" class="block">
                <b-tab-item label="Merchandises" icon="food-fork-drink">
                    <div class="container" style="margin-top: 2%">
                      <div class="columns is-multiline is-mobile">
                          <div class="column is-3-desktop is-12-mobile is-mobile" v-for="merch of merchandises">
                            <f-merch-card :merchandise="merch"></f-merch-card>
                          </div>
                      </div>
                    </div>
                </b-tab-item>
                <b-tab-item label="Sellers" icon="store">
                  <div class="container" style="margin-top: 2%">
                    <div class="columns is-multiline is-mobile">
                        <div class="column is-12-desktop is-12-mobile is-mobile" v-for="seller of sellers">
                          <f-seller-card :seller="seller"></f-seller-card>
                        </div>
                    </div>
                  </div>
                </b-tab-item>
            </b-tabs>
        </section>
    </div>
</template>

<script>
    export default {
        name: "TitleWelcome",
        props: {
            sellers:{
                default: () => []
            },
            merchandises:{
                default: () => []
            }
        },
        data: function () {
            return {
                image: "/img/sushi.jpg",
            }
        },
        methods: {
            searchBarObserver(isVisible, entry) {
                this.$events.emit('hideSearchBar', !isVisible)
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