<template>
    <form :action="action" method="post">
        <input type="hidden" name="authenticity_token" :value="token">
        <div class="form">
            <div class="filed" v-for="(value, key) in item">
                <div class="control has-icons-left has-icons-right">
                    <input v-if=""
                           :placeholder="key"
                           type="text"
                           name="customer[username]"
                           :id="key"
                           class="input is-medium">
                </div>
            </div>
        </div>
    </form>
</template>

<script>
    export default {
        name: "AddFormComponent",
        props: {
            prop: {
                default: () => {
                }
            }
        },
        computed: {
            token: function () {
                return this.prop.token
            },
            item: function () {
                return this.prop.item
            },
            action: function () {
                return this.prop.action
            }
        }
    }
</script>

<style scoped>

</style>