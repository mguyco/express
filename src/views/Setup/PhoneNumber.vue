<template>
	<v-autocomplete
		:no-data-text="`Loading...`" 
		:items="items"
		item-text="TN"
		item-value="TN"
		v-model="phoneNumber"
		label="Phone Number" 
		@change="setPhoneNumber" 
		@click:clear="setPhoneNumber" 
		clearable 
		outlined>
		<template v-slot:item="data">
			<v-list-item-content v-if="data.item.hasOwnProperty('TN')">
				<v-list-item-title>
					{{ data.item.TN }}
				</v-list-item-title>
				<v-list-item-subtitle class="text-caption">
					<span v-if="data.item.Status == 'Assigned'">
						<span class="green--text">New number</span>
					</span>
					<span v-else>
						Existing number
					</span>
				</v-list-item-subtitle>
			</v-list-item-content>
			<v-list-item-content v-else>
				<v-list-item-title class="grey--text">{{ data.item }}</v-list-item-title>
			</v-list-item-content>
		</template>
	</v-autocomplete>
</template>

<script>
export default {
	props: {
		phoneNumberValue: String
	},
	data() {
		return {
			phoneNumber: null
		}
	},
	computed: {
		order() {
			return this.$store.getters.order
		},
		phoneNumbers() {
			return this.order.phoneNumbers
		},
		items() {
			return ['Extension Only', ...this.phoneNumbers]
		}
	},
	methods: {
		setPhoneNumber() {
			this.$emit('set', (this.phoneNumber == 'Extension Only' ? null : this.phoneNumber))
		}
	},
	mounted() {
		this.phoneNumber = this.phoneNumberValue
	},
	watch: {
		phoneNumberValue() {
			this.phoneNumber = this.phoneNumberValue
		}
	}
}
</script>