<template>
	<div class="tile is-ancestor">
  <div class="tile is-8">
    <div class="tile is-parent">
      <div class="tile is-child">
        <div class="content">
          <div class="box">
            <p class="title">{{merchandise.name}}</p>
            <div class="box">
              <p class="subtitle">Description:</p>
              {{merchandise.description}}
            </div>

            <div class="box">              
              <p class="subtitle">Cook time:</p>
      			{{merchandise.cook_time}} minutes
            </div>
            <div class="box">
              <p class="subtitle">Price:</p> 
              {{merchandise.price / 100}}
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>

  <div class="tile">
    <div class="tile is-parent">
      <div class="tile is-child">
        <div class="box">
          <p class="title">
            <a :href="`/sellers/${merchandise.seller.id}`">{{merchandise.seller.name}}</a>
            info
          </p>
          <f-seller-rating :is_usable="false" :seller="merchandise.seller"></f-seller-rating>
        </div>
        <div class="box">
          <div class="buttons">
              <a @click="addToCart" class="button is-primary is-fullwidth">
                <b-icon icon="cart-plus"></b-icon> &nbsp; Add to cart</a>
              <a :href="`/merchandises/${merchandise.id}/edit`" class="button is-primary is-fullwidth" v-if="editable">Edit merchandise</a>
            </div>
        </div>
      </div>
    </div>
  </div>
</div>
</template>

<script>
	export default{
		name: 'merch-page',
		props:{
			merchandise:{
				default: () => {}
			},
			editable:{
				default: false
			}
		},
		methods:{
			addToCart(){
				this.$events.emit('addMerchandiseToCart', this.merchandise)
			}
		}
	}
</script>

<style>
	
</style>