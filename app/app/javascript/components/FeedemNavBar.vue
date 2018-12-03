<template>
    <nav class="navbar is-fixed-top has-background-primary" role="navigation"
         aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="/">
                <img src="/img/logo.png">
                <h2 class="white">FeedEm</h2>
            </a>

            <a role="button" @click="openBar" class="navbar-burger burger" aria-label="menu" aria-expanded="false"
               data-target="navBarItems">
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
            </a>
        </div>

        <div id="navBarItems" class="navbar-menu" :class="{'is-active': active}">
            <div class="navbar-start">
                <a href="/" class="navbar-item white">
                    Home
                </a>

                <a href="https://github.com/s3rius/feedEm/blob/master/README.md" class="navbar-item white">
                    Documentation
                </a>

                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link white">
                        Models
                    </a>

                    <div class="navbar-dropdown">
                        <a href="/customers" class="navbar-item">
                            Customers
                        </a>
                        <a href="/sellers" class="navbar-item">
                            Sellers
                        </a>
                        <a href="/admins" class="navbar-item">
                            Admins
                        </a>
                        <hr class="navbar-divider">
                        <a href="/merchandises" class="navbar-item">
                            Merchandises
                        </a>
                        <a href="/orders" class="navbar-item">
                            Orders
                        </a>
                        <a href="/order_items" class="navbar-item">
                            Order items
                        </a>
                        <a href="/cards" class="navbar-item">
                            Cards
                        </a>
                        <hr class="navbar-divider">
                        <a href="https://github.com/s3rius/feedEm/issues/new" class="navbar-item">
                            Report an issue
                        </a>
                    </div>
                </div>
            </div>

            <div class="navbar-end">
                <div class="navbar-item" v-show="visible_search">
                    <f-search></f-search>
                </div>
                <div class="navbar-item">
                    <div class="buttons">
                        <a class="button is-primary">
                            <strong>Sign up</strong>
                        </a>
                        <a class="button is-light">
                            Log in
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</template>

<script>
    import FeedemSearch from "./searchbar/SearchBar";

    export default {
        name: "FeedemNavBar",
        components: {
            'f-search': FeedemSearch
        },
        props: {
            visible_search: {
                default: true
            }
        },
        data: function () {
            return {
                active: false
            }
        },
        methods: {
            openBar: function (event) {
                this.active = !this.active;
            }
        }
    }
</script>

<style scoped lang="scss">
    $mcolor: #7957D5;

    .white {
        color: white;
    }

    .navbar-item.has-dropdown:hover .navbar-link, .navbar-item.has-dropdown.is-active .navbar-link {
        color: $mcolor;
    }

    .is-active {
        .navbar-link {
            color: $mcolor;
        }
        .navbar-item {
            color: $mcolor;
        }
    }


</style>