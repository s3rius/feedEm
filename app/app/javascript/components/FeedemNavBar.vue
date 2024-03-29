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

                <div class="navbar-item has-dropdown is-hoverable" v-if="is_admin_signed_in">
                    <a class="navbar-link white">
                        Admin control
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
                        <hr class="navbar-divider">
                        <a @click="logoutAdmin" class="navbar-item" >
                            Turn admin mode off
                        </a>
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
                    <div class="buttons" v-if="user == null && seller == null">
                        <f-cart></f-cart>
                        <a class="button is-primary" href="/customers/sign_up">
                            <strong>Sign up</strong>
                        </a>
                        <a class="button is-light" href="/customers/sign_in">
                            Log in
                        </a>
                    </div>
                    <div class="buttons" v-else-if="seller != null">
                        <a class="button is-primary" :href="`/sellers/${seller.id}`">
                            <strong>Manage shop</strong>
                        </a>
                        <a class="button is-light" @click="logoutSeller">
                            Sign out
                        </a>
                    </div>
                    <div class="buttons" v-else>
                        <f-cart :user="this.user"></f-cart>
                        <a class="button is-primary" :href="`/customers/${user.id}`">
                            Profile
                        </a>
                        <a class="button is-primary" @click="logout">
                            <strong>Sign out</strong>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </nav>
</template>

<script>
    import FeedemCart from './cart/Cart'

    export default {
        name: "FeedemNavBar",
        components: {
            'f-cart': FeedemCart
        },
        props: {
            user: {
                default: () => null
            },
            is_admin_signed_in: {
                default: false
            },
            token: {
                default: ''
            },
            seller:{
                default: () => null
            }
        },
        data: function () {
            return {
                active: false,
                visible_search: true
            }
        },
        mounted() {
            this.$events.listen('hideSearchBar', eventData => {
                this.visible_search = eventData
            })
        },
        methods: {
            openBar: function (event) {
                this.active = !this.active;
            },
            logout(event) {
                let sign_out = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": window.token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                var component = this;
                sign_out.delete("/customers/sign_out").then((response) => {
                    console.log("Logout successfully");
                    location.reload();
                }).catch((error) => {
                    component.$snackbar.open({
                        message: error,
                        type: "is-danger",
                        position: 'is-bottom-left'
                    });
                    console.log(error);
                });
            },
            logoutSeller(event){
                let sign_out = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": window.token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                var component = this;
                sign_out.delete("/seller_sessions/destroy").then((response) => {
                    location.reload();
                }).catch((error) => {
                    component.$snackbar.open({
                        message: "Can't logout as seller.",
                        type: "is-danger",
                        position: 'is-bottom-left'
                    });
                    console.log(error);
                });
            },
            logoutAdmin(event) {
                let sign_out = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": window.token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                var component = this;
                sign_out.delete("/admins/sign_out").then((response) => {
                    component.$snackbar.open({
                        message: "Logout successfully",
                        type: "is-success",
                        position: 'is-bottom-left'
                    });
                    component.is_admin_signed_in = false;
                }).catch((error) => {
                    component.$snackbar.open({
                        message: "Can't logout as admin.",
                        type: "is-danger",
                        position: 'is-bottom-left'
                    });
                    console.log(error);
                });
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