<template>
	<div>
		<v-dialog 
			v-model="dialog.complete.open"
			overlay-opacity="0.9"
			width="680">
			<v-card>
				<v-card-title>
					Express Setup Complete
				</v-card-title>
				<v-card-text>
					Your new phone system is almost ready!
				</v-card-text>
				<v-card-actions class="pa-5">
					<v-spacer />
					<v-btn 
						color="primary"
						@click="dialog.complete.open = false">Ok, got it
					</v-btn>
				</v-card-actions>
			</v-card>
		</v-dialog>

		<v-container>
			<v-row>
				<v-col cols="12">
					<div class="text-center text-h4 font-weight-thin">
						<v-icon 
							size="64" 
							color="primary">
							mdi-text-box-check-outline
						</v-icon>
						<div class="my-3">
							<span class="text-h4 font-weight-thin">
								Complete Setup
							</span>
							<div class="text-body-1 text--secondary font-weight-light">
								Please review all sections before completing your setup
							</div>
						</div>
					</div>
				</v-col>
			</v-row>
			<v-row class="mt-5">
				<v-col cols="10" offset="1">
					<v-card 
						color="grey lighten-5"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									v-model="expand.placing" 
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-action>
											<v-icon size="32">
												mdi-call-made
											</v-icon>
										</v-list-item-action>
										<v-list-item-content>
											<v-list-item-title class="text-h5 text--primary font-weight-light">
												Calling Line Identity
											</v-list-item-title>
											<v-list-item-subtitle class="text--secondary">
												See how your outbound calls will look to other callers
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-row no-gutters>
												<v-col cols="12" align="center">
													<v-alert 
														v-if="data.callingLineId.name == ''"
														width="480" 
														type="warning"
														outlined
														text>
														<span class="text-body-1">
															<span class="font-weight-bold">Display Name</span> has not been set
														</span>
													</v-alert>

													<v-alert 
														v-if="data.callingLineId.phoneNumber == ''"
														width="480" 
														type="warning"
														outlined
														text>
														<span class="text-body-1">
															<span class="font-weight-bold">Phone Number</span> has not been set
														</span>
													</v-alert>

													<!-- mobile example -->
													<v-card 
														v-if="data.callingLineId.name != '' && data.callingLineId.phoneNumber != ''"
														max-width="385"
														color="info"
														outlined
														dark>
														<v-system-bar 
															lights-out
															dark>
															<v-icon>
																mdi-phone
															</v-icon>
															<v-spacer />
															<v-icon>
																mdi-wifi-strength-4
															</v-icon>
															<v-icon>
																mdi-signal-cellular-outline
															</v-icon>
															<v-icon>
																mdi-battery
															</v-icon>
															<span>
																12:30
															</span>
														</v-system-bar>
														<v-card-title>
															<div class="text-body-1">
																Incoming call
															</div>
															<v-tooltip 
																:value="expand.placing"  
																right>
																<template v-slot:activator="{ on, attrs }">
																	<div 
																		v-bind="attrs" 
																		class="text-h3 pa-1 font-weight-thin"
																		style="border:1px dashed rgba(255,255,0,0.5)">
																		{{ data.callingLineId.phoneNumber }}
																	</div>
																</template>
																<span class="text-body-1">
																	Calling Line Identity Phone Number
																</span>
															</v-tooltip>
															<v-tooltip
																:value="expand.placing" 
																right>
																<template v-slot:activator="{ on, attrs }">
																	<div 
																		v-bind="attrs" 
																		class="text-h5 pa-1 mt-1 font-weight-light" 
																		style="border:1px dashed rgba(255,255,0,0.5);">
																		{{ data.callingLineId.name }}
																	</div>
																</template>
																<span class="text-body-1">
																	Calling Line Identity Display Name
																</span>
															</v-tooltip>
														</v-card-title>
														<v-card-text 
															class="secondary pa-5" 
															style="min-height:240px">
															<div class="text-center">
																<v-icon size="224">
																	mdi-account
																</v-icon>
															</div>
														</v-card-text>
														<v-card-actions class="secondary darken-1 pa-5">
															<v-row no-gutters>
																<v-col cols="6" class="text-center">
																	<v-btn 
																		color="red"
																		large
																		depressed 
																		fab 
																		dark>
																		<v-icon large>
																			mdi-phone-hangup
																		</v-icon>
																	</v-btn>
																	<div class="mt-1 text-caption">
																		Decline
																	</div>
																</v-col>
																<v-col cols="6" class="text-center">
																	<v-btn 
																		color="green"
																		large
																		depressed 
																		fab 
																		dark>
																		<v-icon large>
																			mdi-phone
																		</v-icon>
																	</v-btn>
																	<div class="mt-1 text-caption">
																		Accept
																	</div>
																</v-col>
															</v-row>
														</v-card-actions>
													</v-card>
												</v-col>
											</v-row>
										</v-list-item-content>
									</v-list-item>
								</v-list-group>
							</v-list>
						</v-card-text>
					</v-card>
				</v-col>
			</v-row>
			<v-row class="mt-5">
				<v-col cols="10" offset="1">
					<v-card 
						:color="($vuetify.theme.dark ? '' : 'grey lighten-5')"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									:value="(section == 2 ? true : false)" 
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-action>
											<v-icon size="32">mdi-call-received</v-icon>
										</v-list-item-action>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												Receiving calls
											</v-list-item-title>
											<v-list-item-subtitle>
												Take a look at how your inbound calls will be handled
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row>
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
				<v-col cols="10" offset="1">
					<v-card 
						:color="($vuetify.theme.dark ? '' : 'grey lighten-5')"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									:value="(section == 3 ? true : false)" 
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-action>
											<v-icon size="32">mdi-car-brake-alert</v-icon>
										</v-list-item-action>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												Emergency calls
											</v-list-item-title>
											<v-list-item-subtitle>
												Validate your address is correct for using emergency services
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row>
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
				<v-col cols="10" offset="1">
					<v-card 
						:color="($vuetify.theme.dark ? '' : 'grey lighten-5')"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									:value="(section == 4 ? true : false)" 
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-action>
											<v-icon size="32">mdi-account-group</v-icon>
										</v-list-item-action>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												User directory
											</v-list-item-title>
											<v-list-item-subtitle>
												Review basic user information is correct
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row>
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
				<v-col cols="10" offset="1">
					<v-card 
						:color="($vuetify.theme.dark ? '' : 'grey lighten-5')"
						:disabled="!valid">
						<v-card-text>
							<v-list color="transparent">
								<v-list-group 
									:value="(section == 4 ? true : false)" 
									color="grey darken-2">
									<template v-slot:activator>
										<v-list-item-action>
											<v-icon size="32">mdi-home-group</v-icon>
										</v-list-item-action>
										<v-list-item-content>
											<v-list-item-title class="text-h5 font-weight-light">
												Working from home
											</v-list-item-title>
											<v-list-item-subtitle>
												Let's make sure your users have everything they need
											</v-list-item-subtitle>
										</v-list-item-content>
									</template>
									<v-list-item>
										<v-list-item-content>
											<v-container>
												<v-row>
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
				<v-col cols="12" align="center">
					<v-btn 
						:disabled="!valid || loading"
						class="mt-5 green white--text"
						@click="submit"
						large
						rounded>Complete Setup
					</v-btn>
					<div class="pa-5 text-body-1 text-center grey--text font-weight-light">
						You may be contacted to verify some configuration details before your phone service is fully provisioned
					</div>
				</v-col>
			</v-row>
		</v-container>
	</div>
</template>

<script>
export default {
	computed: {
		id() {
			return this.$store.getters.id
		},
		loading() {
			return this.$store.getters.loading
		},
		valid() {
			return this.$store.getters.valid
		},
		data() {
			return this.$store.getters.data
		},
		order() {
			return this.$store.getters.order
		}
	},
	data() {
		return {
			section: 0,
			completed: false,
			dialog: {
				complete: {
					open: false
				},
				error: {
					open: false
				}
			},
			expand: {
				placing: false,
				receiving: false,
				emergency: false,
				directory: false,
				home: false
			}
		}
	},
	methods: {
		close() {
			for(let key in this.dialog) {
				this.dialog[key].open = false
			}
		},
		submit() {
			if(this.completed) return false

			this.dialog.complete.open = false
			this.dialog.error.open = false

			this.setState({ loading: true })
			this.showSnackbar({ loading: true })

			const payload = {
				id: this.id,
				order: this.order,
				data: this.data
			}

			const request = this.API('complete', payload, 'POST')
			.then(response => {
				if(Object.prototype.hasOwnProperty.call(response, 'error')) {
					this.showSnackbar(response)
				}

				else {
					this.dialog.complete.open = true

					this.hideSnackbar()
				}
			})

			request.then(() => {
				this.setState({ loading: false })

				this.completed = true
			})
		}
	}
}
</script>