import Vue from 'vue'
import App from './App.vue'

import vuetify from './plugins/vuetify';
import store from './store'
import router from './router'
import mixins from './mixins'

Vue.config.productionTip = false

Vue.mixin(mixins)

new Vue({
	vuetify,
	store,
	router,
	render: h => h(App)
}).$mount('#app')
