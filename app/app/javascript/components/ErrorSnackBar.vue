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
            }
        },
        mounted: function () {
            if (this.errors.length > 0) {
                this.errors.forEach(err => {
                    this.$snackbar.open({
                        message: `Error found: ${err}`,
                        type: 'is-danger',
                        position: 'is-bottom-left'
                    })
                });

            }
        }
    }
</script>

<style scoped>

</style>