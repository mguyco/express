<template>
	<v-dialog
		v-model="open"
		width="480">
		<v-card class="pa-5">
			<v-card-title>{{ data.name }}</v-card-title>
			<v-card-subtitle>Extension {{ data.extension }}</v-card-subtitle>
			<v-card-text>
				<v-row>
					<v-col cols="12" align="center">
						<div class="body-1">Are you sure you want to delete this ring group?</div>
					</v-col>
				</v-row>
			</v-card-text>
			<v-card-actions>
				<v-spacer />
				<v-btn 
					@click="$emit('delete', group)" 
					color="primary">Delete
				</v-btn>
				<v-btn 
					@click="$emit('close')"
					text>Cancel
				</v-btn>
				<v-spacer />
			</v-card-actions>
		</v-card>
	</v-dialog>
</template>

<script>
export default {
	props: {
		open: Boolean,
		group: Object
	},
	data() {
		return {
			data: {
				name: '',
				extension: ''
			}
		}
	},
	watch: {
		open: function(open) {
			if(open === true) {
				this.data = this.group
			}
		}
	}
}
</script>