<template>
	<v-app id="app">
		<Snackbar />

		<transition name="fade" mode="out-in">
	    	<router-view />
	    </transition>
	</v-app>
</template>

<script>
import Snackbar from '@/components/Snackbar'

export default {
	components: {
		Snackbar
	},
	computed: {
		dark() {
			//return this.$store.getters.dark
			//return process.env.NODE_ENV !== 'production'
			return false
		}
	},
	mounted() {
		this.$vuetify.theme.dark = this.dark

		if(window.location.pathname.length < 32) {
			this.$router.replace({ 
				path: '/expired-or-invalid/activate'
			})
		}
	},
	watch: {
		dark() {
			this.$vuetify.theme.dark = this.dark
		}
	}
}
</script>

<style>
.fade-enter-active, .fade-leave-active {
	transition: opacity 1.25s ease-out;
}

.fade-enter, .fade-leave-to {
	opacity: 0;
}
</style>