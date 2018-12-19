<template>
    <div class="card">
        <header class="card-header">
            <p class="card-header-title">
                {{ this.seller.name }}
            </p>
            <div class="card-header-icon">
                <b-icon icon="food-fork-drink"></b-icon>
            </div>
        </header>
        <footer class="card-footer">
            <a @click="likeThat" class="card-footer-item">
                <b-icon icon="thumb-up"></b-icon>
                <p>{{ this.likes }} </p> Likes</a>
            <a @click="dislikeThat" class="card-footer-item">
                <b-icon icon="thumb-down"></b-icon>
                <p>{{this.dislikes}} </p> Dislikes</a>
            <a :href="getLink()" class="card-footer-item">Open</a>
        </footer>
    </div>
</template>

<script>
    import BIcon from "buefy/src/components/icon/Icon";

    export default {
        components: {BIcon},
        name: "Seller",
        props: {
            seller: {
                id: null,
                name: null,
                likes: 0,
                dislikes: 0
            }
        },
        data: function () {
            return {
                likes: 0,
                dislikes: 0
            }
        },
        created: function () {
            this.likes = this.seller.likes;
            this.dislikes = this.seller.dislikes;
        },
        methods: {
            getLink() {
                return `/sellers/${this.seller.id}`
            },
            likeThat(event) {
                var component = this;
                let token = window.token;
                let axi_like = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                axi_like.post(`/sellers/liked/${this.seller.id}`)
                    .then(function () {
                        console.log("ok");
                        component.likes = component.likes + 1;
                    })
                    .catch(function (error) {
                        console.log(error);
                        component.$snackbar.open({
                            message: "Can't add like for this seller",
                            type: "is-danger",
                            position: 'is-bottom-left'
                        });
                    });
            },
            dislikeThat(event) {
                var component = this;
                let token = window.token;
                let axi_dislike = this.axios.create({
                    headers: {
                        'X-Requested-With': 'XMLHttpRequest',
                        "X-CSRF-Token": token,
                        'Content-Type': 'application/json',
                        'Accept': 'application/json'
                    }
                });
                axi_dislike.post(`/sellers/disliked/${this.seller.id}`)
                    .then(function () {
                        console.log("ok");
                        component.dislikes = component.dislikes + 1;
                    })
                    .catch(function (error) {
                        console.log(error);
                        component.$snackbar.open({
                            message: "Can't add dislike for this seller",
                            type: "is-danger",
                            position: 'is-bottom-left'
                        });
                    });
            }
        }
    }
</script>

<style scoped>

</style>