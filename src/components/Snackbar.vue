<template>
	<v-snackbar 
		v-model="snackbar.visible" 
		:timeout="snackbar.timeout" 
		:color="snackbar.color"
		top
		centered
		app>
		<template v-slot:action="{ attrs }">
			<v-btn 
				v-if="snackbar.btn === true" 
				v-bind="attrs" 
				@click="hideSnackbar"
				right 
				icon>
				<v-icon>mdi-close</v-icon>
			</v-btn>
		</template>
		<div>
			{{ snackbar.text }}
		</div>
	</v-snackbar>
</template>

<script>
export default {
	computed: {
		snackbar() {
			return this.$store.state.snackbar
		}
	}
}
</script>