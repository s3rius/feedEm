<template>
<div>
	<p><a @click="rate(true)" v-if="is_usable"><b-icon icon="thumb-up" ></b-icon></a> Likes : {{likes}}</p>
	<p><a @click="rate(false)" v-if="is_usable"><b-icon  icon="thumb-down"></b-icon></a> Dislikes : {{dislikes}}</p>
</div>
</template>

<script>
import BIcon from "buefy/src/components/icon/Icon";

export default{
	name: "seller-rating",
	components:{BIcon},
	data(){
		return {
			likes: 0,
			dislikes: 0
		}
	},
	props:{
		is_usable: {
			default: true
		},
		seller:{
			default: () => null
		}
	},
	mounted(){
		this.likes = this.seller.likes;
		this.dislikes = this.seller.dislikes;
	},
	methods: {
	    rate(is_like, event) {
			var component = this;
	        let token = window.token;
	        let url = `/sellers/disliked/${this.seller.id}`
	        let message = "Can't add dislike for this seller"
	        if (is_like){
	        	message = "Can't add like for this seller"
	        	url = `/sellers/liked/${this.seller.id}`
	        }
	        let axi_rate = this.axios.create({
	            headers: {
	                'X-Requested-With': 'XMLHttpRequest',
	                "X-CSRF-Token": token,
	                'Content-Type': 'application/json',
	                'Accept': 'application/json'
	            }
	        });
	        axi_rate.post(url)
            .then(function () {
                console.log("ok");
                 if (is_like){
		        	component.likes += 1;
		        }else{
					component.dislikes += 1;
	        	}
            })
            .catch(function (error) {
                console.log(error);
                component.$snackbar.open({
                    message: message,
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