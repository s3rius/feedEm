<template>
    <section class="hero is-small is-primary is-bold">
        <div class="hero-body">
            <div class="container">
                <h1 class="title">
                    {{title}}
                </h1>
                <h2 class="subtitle">
                    {{sub_title}}
                </h2>
            </div>
        </div>
    </section>
</template>

<script>
    export default {
        props: {
            title: {
                default: ""
            },
            sub_title: {
                default: ""
            }
        },
        name: "TitleComponent"
    }
</script>

<style scoped>

</style>