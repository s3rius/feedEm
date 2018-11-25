/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log("Hello World from Webpacker");
import TurbolinksAdapter from "vue-turbolinks";
import Vue from "vue/dist/vue.esm";
import App from "../components/app";
import Buefy from 'buefy'
import 'buefy/dist/buefy.css'
import FeedEmNavBar from "../components/FeedemNavBar";
import FeedemTitle from "../components/TitleComponent";
import FeedemForm from "../components/AddFormComponent";
import FeedemErrorSnack from "../components/ErrorSnackBar";

Vue.use(TurbolinksAdapter);
Vue.use(Buefy);
Vue.component("app", App);
Vue.component("f-navbar", FeedEmNavBar);
Vue.component("f-title", FeedemTitle);
Vue.component("f-addform", FeedemForm);
Vue.component("f-error-snack", FeedemErrorSnack);

document.addEventListener("turbolinks:load", () => {
    const mv = new Vue({
        el: ".vue"
    });
});
