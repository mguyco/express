<template>
	<v-dialog
		v-model="open"
		width="480">
		<v-card class="pa-5">
			<v-card-title class="text-h5">
				{{ data.firstName }} {{ data.lastName }}
			</v-card-title>
			<v-card-subtitle class="py-1 text-body-2 text--disabled">
				Extension {{ data.extension }}
			</v-card-subtitle>
			<v-card-text class="pa-5 text-center">
				<div class="text-body-1">
					Are you sure you want to delete this user?
				</div>
			</v-card-text>
			<v-card-actions>
				<v-spacer />
				<v-btn 
					@click="$emit('close')"
					class="text--secondary"
					text>
					Cancel
				</v-btn>
				<v-btn 
					@click="$emit('delete', user)" 
					color="primary">
					Delete
				</v-btn>
			</v-card-actions>
		</v-card>
	</v-dialog>
</template>

<script>
export default {
	props: {
		open: Boolean,
		user: Object
	},
	data() {
		return {
			data: {
				firstName: '',
				lastName: '',
				extension: ''
			}
		}
	},
	watch: {
		open: function(open) {
			if(open == true) {
				this.data = Object.assign({}, this.user)
			}
		}
	}
}
</script>