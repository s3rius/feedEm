<template>
    <nav class="navbar" role="navigation" aria-label="main navigation">
        <div class="navbar-brand">
            <a class="navbar-item" href="/">
                <img src="/img/logo.png">
                <h2 :class="nav_style">FeedEm</h2>
            </a>

            <a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false"
               data-target="navBarItems">
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
                <span aria-hidden="true"></span>
            </a>
        </div>

        <div id="navBarItems" class="navbar-menu">
            <div class="navbar-start">
                <a href="/" class="navbar-item" :class="nav_style">
                    Home
                </a>

                <a href="https://github.com/s3rius/feedEm/blob/master/README.md" class="navbar-item" :class="nav_style">
                    Documentation
                </a>

                <div class="navbar-item has-dropdown is-hoverable">
                    <a class="navbar-link" :class="nav_style">
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
                        <a href="https://github.com/s3rius/feedEm/issues" class="navbar-item">
                            Report an issue
                        </a>
                    </div>
                </div>
            </div>

            <div class="navbar-end">
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
    export default {
        name: "FeedemNavBar",
        props: {
            is_white: {
                default: false
            }
        },
        computed: {
            nav_style: function () {
                return {
                    white: this.is_white
                }
            }
        }
    }
</script>

<style scoped>
    .white {
        color: white;
    }
</style>