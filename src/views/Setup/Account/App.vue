<template>
	<div>
		<v-container fluid class="fill-height">
			<v-row>
				<v-col cols="12" align="center">
					<v-icon 
						size="64" 
						color="primary">
						mdi-home-city-outline
					</v-icon>
					<div class="my-3">
						<span class="text-h4 font-weight-thin">
							Account Settings
						</span>
						<div class="text-body-1 text--secondary font-weight-light">
							Setup your calling line identity and regional settings
						</div>
					</div>
				</v-col>
			</v-row>

			<v-row class="mt-5">
				<v-col cols="8" offset="2">
					<v-card 
						color="grey lighten-5"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									v-model="expand.callingLineId" 
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-action>
											<v-icon size="32">
												mdi-phone-settings
											</v-icon>
										</v-list-item-action>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												Calling Line Identity
											</v-list-item-title>
											<v-list-item-subtitle class="text-body-1">
												Configure your display name and phone number
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Display Name
														</div>
														<div class="text--secondary">
															No more than 15 characters will be displayed
														</div>
													</v-col>
													<v-col cols="6">
														<v-text-field 
															v-model="data.callingLineId.name"
															counter="15"
															@change="update" />
													</v-col>
												</v-row>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Phone Number
														</div>
														<div class="text--secondary">
															You can select from the list or type in a number
														</div>
													</v-col>
													<v-col cols="6">
														<v-combobox
															v-model="data.callingLineId.phoneNumber"
															:items="phoneNumbers"
															@change="update" />
													</v-col>
												</v-row>
											</v-container>
										</v-list-item-content>
									</v-list-item>
								</v-list-group>
							</v-list>
						</v-card-text>
					</v-card>
				</v-col>
			</v-row>

			<v-row 
				v-if="account.enterpriseMappingID == null"
				class="mt-5">
				<v-col cols="8" offset="2">
					<v-card 
						:color="($vuetify.theme.dark ? '' : 'grey lighten-5')"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									v-model="expand.extensions" 
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-action>
											<v-icon size="32">mdi-dialpad</v-icon>
										</v-list-item-action>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												Extension Dialing
											</v-list-item-title>
											<v-list-item-subtitle v-if="!expand.extensions">
												Used for internal calls and transfering calls
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1">Extension Digits</div>
													</v-col>
													<v-col cols="3">
														<v-select
															v-model="data.extension.digits"
															:items="['2 Digits','3 Digits','4 Digits']" />
													</v-col>
												</v-row>
											</v-container>
										</v-list-item-content>
									</v-list-item>
								</v-list-group>
							</v-list>
						</v-card-text>
					</v-card>
				</v-col>
			</v-row>

			<v-row class="mt-5">
				<v-col cols="8" offset="2">
					<v-card 
						color="grey lighten-5"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									v-model="expand.region"
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-avatar>
											<v-icon size="32">
												mdi-earth
											</v-icon>
										</v-list-item-avatar>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												Regional Information
											</v-list-item-title>
											<v-list-item-subtitle class="text-body-1">
												Set the default time zone and country settings
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Country
														</div>
													</v-col>
													<v-col cols="6">
														<v-autocomplete
															v-model="data.region.country"
															:items="['United States','Australia','United Kingdom']" 
															@change="update" />
													</v-col>
												</v-row>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Time Zone
														</div>
													</v-col>
													<v-col cols="6">
														<v-autocomplete
															v-model="data.region.timeZone"  
															:items="['America/New_York','America/Chicago','America/Los_Angeles']"
															@change="update" />
													</v-col>
												</v-row>
												<v-row 
													v-if="account.enterpriseMappingID == null"
													align="center"
													no-gutters>
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Website
														</div>
													</v-col>
													<v-col cols="6">
														<v-text-field 
															v-model="data.domain"
															@change="update" />
													</v-col>
												</v-row>
											</v-container>
										</v-list-item-content>
									</v-list-item>
								</v-list-group>
							</v-list>
						</v-card-text>
					</v-card>
				</v-col>
			</v-row>

			<v-row class="mt-5">
				<v-col cols="8" offset="2">
					<v-card 
						:color="($vuetify.theme.dark ? '' : 'grey lighten-5')"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									v-model="expand.emergency"
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-avatar>
											<v-icon size="32">
												mdi-car-brake-alert
											</v-icon>
										</v-list-item-avatar>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												Emergency Calling
											</v-list-item-title>
											<v-list-item-subtitle class="text-body-1">
												Setup your address that will be registered for using emergency services
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Street Address
														</div>
													</v-col>
													<v-col cols="6">
														<v-text-field 
															v-model="data.region.addressLine1" 
															@change="update" />
													</v-col>
												</v-row>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Apartment / Suite
														</div>
													</v-col>
													<v-col cols="6">
														<v-text-field 
															v-model="data.region.addressLine2" 
															@change="update" />
													</v-col>
												</v-row>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															City
														</div>
													</v-col>
													<v-col cols="6">
														<v-text-field 
															v-model="data.region.city" 
															@change="update" />
													</v-col>
												</v-row>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															State / Province
														</div>
													</v-col>
													<v-col cols="6">
														<v-text-field 
															v-model="data.region.state" 
															@change="update" />
													</v-col>
												</v-row>
												<v-row no-gutters align="center">
													<v-col cols="6">
														<div class="text-body-1 text--primary">
															Zip Code
														</div>
													</v-col>
													<v-col cols="6">
														<v-text-field 
															v-model="data.region.zip" 
															@change="update" />
													</v-col>
												</v-row>
											</v-container>
										</v-list-item-content>
									</v-list-item>
								</v-list-group>
							</v-list>
						</v-card-text>
					</v-card>
				</v-col>
			</v-row>
		</v-container>
	</div>
</template>

<script>
export default {
	computed: {
		valid() {
			return this.$store.getters.valid
		},
		id() {
			return this.$store.getters.id
		},
		account() {
			return this.$store.getters.account
		},
		order() {
			return this.$store.getters.order
		},
		phoneNumbers() {
			return this.order.phoneNumbers.map(item => {
				return item.TN
			})
		}
	},
	methods: {
		update() {
			this.$emit('update', this.data)

			this.initialize()
		},
		initialize() {
			const express = this.getJSON(this.id)

			if(Object.prototype.hasOwnProperty.call(express, 'data')) {
				this.data = express.data
			}
		}
	},
	watch: {
		account() {
			this.initialize()
		}
	},
	data() {
		return {
			section: 1,
			expand: {
				callingLineId: true,
				extensions: false,
				region: false,
				emergency: false
			},
			alert: false,
			data: {
				callingLineId: {
					name: '',
					phoneNumber: ''
				},
				domain: '',
				extension: {
					digits: 4,
				},
				region: {
					addressLine1: '',
					addressLine2: '',
					city: '',
					country: '',
					state: 'United States',
					timeZone: 'America/New_York',
					zip: ''
				}
			}
		}
	},
	mounted() {
		this.initialize()
	}
}
</script>