<template>
    <div class="card" :class="{'is-hidden': this.hidden}">
        <header class="card-header">
            <p class="card-header-title">
                Card
            </p>
            <div class="card-header-icon">
                <b-icon icon="credit-card"></b-icon>
            </div>
        </header>
        <div class="card-content">
            <div class="content has-text-centered">
                ****-****-****-{{this.card.card}}
                <br>
            </div>
        </div>
        <footer class="card-footer">
            <a @click="removeCard" class="card-footer-item">
                <b-icon icon="delete"></b-icon>
                Remove</a>
            <a :href="getLink()" class="card-footer-item">Open</a>
        </footer>
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        name: "CreditCard",
        components: {BIcon},
        props: {
            card: {
                default: function () {
                    return {}
                }
            },
        },
        data: function () {
            return {
                hidden: false
            }
        },
        methods: {
            removeCard() {
                this.hidden = true;
                let token = window.token;
                let axi_delete = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                axi_delete.delete(`/cards/${this.card.id}`)
                    .then(function (response) {
                        console.log(response)
                    })
            },
            getLink() {
                return `/cards/${this.card.id}`
            }
        }
    }
</script>

<style scoped>
    .is-hidden {
        display: none;
    }

    .card {
        margin-top: 10px;
    }
</style>