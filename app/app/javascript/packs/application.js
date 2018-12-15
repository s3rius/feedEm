/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log("Vue app rendering is running.");
import TurbolinksAdapter from "vue-turbolinks";
import Vue from "vue/dist/vue.esm";
import VueEvents from 'vue-events'
import axios from 'axios'
import VueAxios from 'vue-axios'
import Buefy from 'buefy';
import 'buefy/dist/buefy.css';
import 'bulma-extensions/bulma-badge/dist/css/bulma-badge.min.css'
import 'bulma-extensions/bulma-pageloader/dist/css/bulma-pageloader.min.css'
import 'vue-resize/dist/vue-resize.css';
import '@mdi/font/css/materialdesignicons.min.css';
import VueObserveVisibility from 'vue-observe-visibility';
import FeedEmNavBar from "../components/FeedemNavBar";
import FeedemTitle from "../components/TitleSimple";
import FeedemErrorSnack from "../components/SnackBar";
import FeedemTitleWelcome from "../components/TitleWelcome";
import FeedemMerchandiseCard from "../components/models/Merchandise";
import FeedemSellerCard from "../components/models/Seller";
import FeedemAddCreditCard from "../components/forms/AddCard";
import FeedemCreditCard from "../components/models/CreditCard";


Vue.use(TurbolinksAdapter);
Vue.use(Buefy);
Vue.use(VueEvents);
Vue.use(VueAxios, axios);
Vue.use(VueObserveVisibility);
Vue.component("f-navbar", FeedEmNavBar);
Vue.component("f-title", FeedemTitle);
Vue.component("f-snack", FeedemErrorSnack);
Vue.component('f-welcome-title', FeedemTitleWelcome);
Vue.component('f-merch-card', FeedemMerchandiseCard);
Vue.component('f-seller-card', FeedemSellerCard);
Vue.component('f-credit-card', FeedemCreditCard);
Vue.component('f-add-credit-card', FeedemAddCreditCard);

document.addEventListener("turbolinks:click", () => {
    window.loaded = false;
    setTimeout(function () {
        if (!window.loaded) {
            var pageloader = document.getElementById("pageloader");
            if (!pageloader.classList.contains("is-active")) {
                pageloader.classList.toggle('is-active');
            }
        }
    }, 2000);

});

document.addEventListener("turbolinks:load", () => {
    window.loaded = true;
    var pageloader = document.getElementById("pageloader");
    if (pageloader.classList.contains("is-active")) {
        pageloader.classList.toggle('is-active');
    }
    const mv = new Vue({
        el: ".vue"
    });
    window.token = document.getElementsByName("super-token")[0].content;
});
