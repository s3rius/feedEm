<template>
    <div class="card">
        <header class="card-header">
            <p class="card-header-title">
                Component
            </p>
        </header>
        <div class="card-content">
            <div class="content">
                <p></p>
                <p></p>
                <p></p>
                <time datetime="2016-1-1">11:09 PM - 1 Jan 2016</time>
            </div>
        </div>
        <footer class="card-footer">
            <a href="#" class="card-footer-item">Show</a>
            <a href="#" class="card-footer-item">Edit</a>
            <a href="#" class="card-footer-item">Delete</a>
        </footer>
    </div>
</template>

<script>
    export default {
        name: "CustomerCard",
        props: {
            item: {
                default: () => {
                }
            }
        },

    }
</script>

<style scoped>

</style>