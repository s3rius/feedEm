<template>
	<div class="tile is-ancestor">
    <div class="tile is-vertical is-8">
      <div class="tile">
      <div class="tile is-parent">
        <article class="tile is-child">
          <div class="content">
          	<div v-if="items.length > 0">
	          <div v-for="item of items">
	          	<div v-if="item.type == 'Order item'">
	            	<f-merch-card :merchandise="item.object" v-if="showMerchandises"></f-merch-card>
	            </div>
	            <div v-else>
	            	<f-seller-card :seller="item.object" v-if="showSellers"></f-seller-card>
	            </div>
	          </div>
	        </div>
	        <div class="has-text-centered" style="margin-top: 3%;" v-else>
	        	<p class="title">
	        		Nothing to show
	        	</p>
	        </div>
          </div>
        </article>
      </div>
    </div>
  </div>
  <div class="tile is-parent is-vertical">
        <article class="tile is-child">
        <div class="content">
          <div class="content">
            <div class="box">
				<p class="title">Search parameters</p>
				Display items
      			<div class="field">
                  <b-switch v-model="showSellers">
                      Sellers
                  </b-switch>
              </div>
               <div class="field">
                <b-switch v-model="showMerchandises">
                    Merchandises
                </b-switch>
              </div>
            </div>
          </div>
        </div>
      </article>
    </div>
</div>
</template>

<script>
	export default{
		name: 'search-page',
		props:{
			result: {
				default: () => {}
			}
		},
		data(){
			return {
				status: "ok",
				items: [],
				showSellers: true,
				showMerchandises: true
			}
		},
		mounted(){
			this.status = this.result.res;
			this.items  = this.result.data;
		}
	}
</script>

<style scoped>

</style>