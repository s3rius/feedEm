<template>
    <div class="searchItem">
        <b>#{{item.id}}</b>
        <span>{{ item.name }}</span>
        <abbr>{{item.body}}</abbr>
    </div>
</template>

<script>
    export default {
        props: {
            item: {required: true},
            searchText: {required: true}
        }
    }
</script>

<style scoped lang="scss">
    .searchItem {
        background-color: #fff;
    }

</style>