<template>
    <div>
        <section class="hero is-medium" v-bind:style="{ 'background-image': 'url(' + image + ')' }">
            <div class="hero-head">
                <f-navbar :is_white="true"></f-navbar>
            </div>
            <div class="hero-body has-text-centered">
                <f-search></f-search>
            </div>
            <div class="hero-foot">
                <nav class="tabs is-boxed is-fullwidth">
                    <div class="container">
                        <ul>
                            <li class="is-active"><a>Available merchandises</a></li>
                            <li><a class="has-text-white">Sellers</a></li>
                        </ul>
                    </div>
                </nav>
            </div>
        </section>
        <section id="tabs">

        </section>
    </div>
</template>

<script>

    export default {
        name: "TitleWelcome",
        data: function () {
            return {
                image: "img/sushi.jpg"
            }
        }
    }
</script>

<style scoped>
    .hero {
        background-size: cover;
        background-position: center;
    }
</style>