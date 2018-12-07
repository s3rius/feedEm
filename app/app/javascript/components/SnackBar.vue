<template>
    <div class="errors">

    </div>
</template>

<script>
    export default {
        name: "ErrorSnackBar",
        props: {
            errors: {
                default: () => []
            },
            type: {
                default: 'is-danger'
            }
        },
        mounted: function () {
            if (this.errors.length > 0) {
                this.errors.forEach(err => {
                    this.$snackbar.open({
                        message: err,
                        type: this.type,
                        position: 'is-bottom-left'
                    })
                });

            }
        }
    }
</script>

<style scoped>

</style>