<template>
	<v-dialog
		v-model="open"
		fullscreen>
		<v-card>
			<v-toolbar 
				class="mb-5" 
				color="primary" 
				dark>
				<v-row no-gutters>
					<v-col cols="8">
						<v-tooltip bottom>
							<template v-slot:activator="{ on }">
								<v-btn 
									@click="back"
									v-on="on"
									class="mr-5"
									absolute 
									large 
									icon>
									<v-icon large>
										mdi-arrow-left
									</v-icon>
								</v-btn>
							</template>
							Go back
						</v-tooltip>
						<div class="text-h5 ml-15">
							<div v-if="edit === null">
								Create New User
							</div>
							<div v-else>
								{{ user.firstName }} {{ user.lastName }}
							</div>
							<div class="text-body-2" style="opacity:0.77">
								<div v-if="edit === null">
									User {{ users.length + 1 }} of {{ getQuantity('ordered', bundles) }}
								</div>
								<div v-else>
									Edit User
								</div>
							</div>
						</div>
					</v-col>
					<v-col cols="3">
						<v-tabs 
							v-model="tab"
							background-color="primary"
							right>
							<v-tab 
								v-for="(item,index) in visibleTabs"
								:key="`tabs-${index}`">
								{{ item.title }}
							</v-tab>
						</v-tabs>
					</v-col>
					<v-col cols="1" align="right">
						<v-btn 
							@click="close"
							icon>
							<v-icon>
								mdi-close
							</v-icon>
						</v-btn>
					</v-col>
				</v-row>
			</v-toolbar>
			<v-tabs-items v-model="tab">
				<!-- Profile -->
				<v-tab-item>
					<v-form ref="profile">
						<v-container>
							<v-row class="mb-5">
								<v-col cols="12" align="center">
									<div class="mt-5 text-h4 font-weight-light">
										User Profile
									</div>
									<div class="text-body-1 text--secondary">
										Enter the basic profile details about the user
									</div>
								</v-col>
							</v-row>
							<v-row class="mt-5" align="center" justify="center">
								<v-col cols="4">
									<v-text-field 
										label="First Name"
										v-model="user.firstName"
										:rules="[rules.required]"
										autofocus
										outlined />
								</v-col>
								<v-col cols="4">
									<v-text-field 
										v-model="user.lastName"
										label="Last Name"
										:rules="[rules.required]"
										outlined />
								</v-col>
							</v-row>
							<v-row align="center" justify="center">
								<v-col cols="4">
									<PhoneNumber 
										:phoneNumberValue="user.phoneNumber" 
										@set="user.phoneNumber = $event" />
								</v-col>
								<v-col cols="4">
									<v-text-field 
										v-model="user.extension"
										label="Extension"
										:rules="[rules.required,rules.extension]"
										outlined />
								</v-col>
							</v-row>
							<v-row align="center" justify="center">
								<v-col cols="4">
									<v-text-field 
										label="Email Address"
										v-model="user.emailAddress"
										:rules="[rules.email]"
										outlined />
								</v-col>
								<v-col cols="4">
									<v-select
										label="Location"
										v-model="user.location"
										:items="['','Works in office','Works from home','Frequent traveler']"
										outlined />
								</v-col>
							</v-row>
							<v-row class="mt-5">
								<v-col 
									cols="4" 
									offset="4"
									align="center">
									<template v-if="catalog.bundles.length == 1">
										<v-btn 
											class="px-5 mb-5 green white--text" 
											@click="save"
											v-html="(user.id === null ? 'Create User' : 'Update User')"
											large 
											rounded>
										</v-btn>
									</template>
									<template v-else>
										<v-btn 
											class="px-5 mb-5 green white--text" 
											@click="tab++"
											large 
											rounded>
											Continue
										</v-btn>
									</template>
								</v-col>
								<v-col cols="2" align="right">
									<v-btn
										v-if="user.id !== null"
										color="red"
										dark
										rounded>
										Delete User
									</v-btn>
								</v-col>
							</v-row>
						</v-container>
					</v-form>
				</v-tab-item>

				<!-- Bundle-->
				<v-tab-item>
					<v-container fluid>
						<v-row class="mb-5">
							<v-col cols="12" align="center">
								<div class="mt-5 text-h4 font-weight-light">
									User Bundle
								</div>
								<div class="text-body-1 text--secondary">
									Select the bundle that best matches the services needed for this user
								</div>
							</v-col>
						</v-row>
						<v-row align="center" justify="center">
							<template v-for="(item, index) in catalog.bundles">
								<v-col cols="3" :key="`bundle-${index}`">
									<v-card 
										height="420"
										:class="'px-4 ' + ($vuetify.theme.dark ? 'secondary darken-2' : 'grey lighten-5')">
										<div class="pt-5 text-center">
											<v-badge 
												v-if="item.name == user.bundle"
												color="green"
												icon="mdi-check" 
												avatar>
												<v-avatar tile>
													<img :src="item.image">
												</v-avatar>
											</v-badge>
											<v-avatar tile v-else>
													<img :src="item.image">
												</v-avatar>
											<div class="text-h5 font-weight-light">{{ item.name }}</div>
											<div style="height:30px" class="px-2 grey--text text-caption">
												{{ item.description }}
											</div>
										</div>
										<v-card-text style="height:175px">
											<v-list 
												color="transparent">
												<v-list-item 
													v-for="feature in item.list" 
													:key="feature">
													<v-list-item-content>
														<v-list-item-title>
															<v-icon 
																color="primary" 
																left>mdi-star
															</v-icon> 
															<span class="pl-2 caption grey--text text--darken-1">
																{{ feature }}
															</span>
														</v-list-item-title>
													</v-list-item-content>
												</v-list-item>
											</v-list>
										</v-card-text>
										<div class="mx-5">
											<v-divider class="my-2" />
											<div class="text-center">
												<span class="green--text">
													{{ item.quantity.available }} Available
												</span>
											</div>
										</div>
										<v-card-actions>
											<v-spacer />
											<v-btn
												v-if="item.productId == user.bundle.productId"
												color="primary"
												class="px-5 mt-1"
												@click="selectBundle(null)" 
												dark>
												<v-icon left>mdi-check</v-icon> 
												Selected
											</v-btn>
											<v-btn 
												color="primary"
												class="px-5 mt-1"
												@click="selectBundle(item)" 
												dark 
												v-else>Select</v-btn>
											<v-spacer />
										</v-card-actions>
									</v-card>
								</v-col>
							</template>
						</v-row>
						<v-row class="mt-15">
							<v-col cols="12" align="center">
								<template v-if="catalog.phones.length <= 1">
									<v-btn 
										class="px-5 mb-5" 
										color="success"
										@click="save"
										rounded
										large>Save User
									</v-btn>
								</template>
								<template v-else>
									<v-btn 
										class="px-5 mb-5 green white--text" 
										@click="tab++"
										rounded>Continue
									</v-btn>
								</template>
							</v-col>
						</v-row>
					</v-container>
				</v-tab-item>

				<!-- Phone -->
				<v-tab-item>
					<v-container>
						<v-row class="mb-5">
							<v-col cols="12" align="center">
								<div class="mt-5 text-h4 font-weight-light">
									Business Phone
								</div>
								<div class="text-body-1 text--secondary">
									Add the desktop phones this user will need in the office or home
								</div>
							</v-col>
						</v-row>
						<v-row justify="center" align="center">
							<template v-for="(item, index) in catalog.phones">
								<v-col cols="3" :key="`phone-${index}`">
									<v-card 
										:class="'phone px-4 ' + ($vuetify.theme.dark ? 'secondary darken-2' : 'grey lighten-5')" 
										height="420">
										<v-badge 
											v-if="user.phone.filter(phone => phone.productId == item.productId).length > 0"
											color="green" 
											right 
											bordered 
											overlap>
											<template v-slot:badge>
												<span>
													{{ user.phone.filter(phone => phone.productId == item.productId)[0].quantity }}
												</span>
											</template>
										</v-badge>
										<div class="pt-5 text-center">
											<v-avatar tile>
												<img :src="item.image">
											</v-avatar>
											<div class="text-h5 font-weight-light">
												{{ item.name }}
											</div>
											<div 
												style="height:30px" 
												class="px-2 grey--text text-body-2">
												{{ item.description }}
											</div>
										</div>
										<v-card-text style="height:180px">
											<v-list color="transparent">
												<v-list-item 
													v-for="feature in item.list" 
													:key="feature">
													<v-list-item-content>
														<v-list-item-title>
															<v-icon 
																color="primary" 
																left>
																mdi-star
															</v-icon> 
															<span class="pl-2 text-body-2 text--secondary">
																{{ feature }}
															</span>
														</v-list-item-title>
													</v-list-item-content>
												</v-list-item>
											</v-list>
										</v-card-text>
										<div class="mx-5">
											<v-divider class="my-2" />
											<div class="text-center">
												<span 
													:class="item.quantity.available > 0 ? 'green--text' : 'red--text'">
													{{ item.quantity.available }} Available
												</span>
												<!--
												<span v-if="item.assigned != ''">
													<span 
														:class="(item.quantity.available - parseInt(item.assigned)) > 0 ? 'green--text' : 'red--text'">
														{{ item.quantity.available - parseInt(item.assigned) }} Available
													</span>
												</span>
												<span v-else>
													<span 
														:class="item.quantity.available > 0 ? 'green--text' : 'red--text'">
														{{ item.quantity.available }} Available
													</span>
												</span>
											-->
											</div>
										</div>
										<v-card-actions>
											<v-row no-gutters>
												<v-col cols="2" offset="4">
													<v-text-field
														class="text-center" 
														placeholder="0"
														v-model="item.assigned" 
														:rules="[rules.quantity]"
														dense 
														solo />
												</v-col>
												<v-col cols="2">
													<v-btn 
														color="primary"
														class="ml-2"
														@click="selectPhone(item)">
														<span v-if="user.phone.filter(phone => phone.productId === item.productId).length > 0">
															Update
														</span>
														<span v-else>
															Add
														</span>
													</v-btn>
												</v-col>
											</v-row>
										</v-card-actions>
									</v-card>
								</v-col>
							</template>
						</v-row>
						<v-row class="mt-15">
							<v-col cols="12" align="center">
								<v-fade-transition>
									<v-btn 
										class="px-5 mb-5 green white--text" 
										@click="tab++"
										large 
										rounded>
										Save User
									</v-btn>
								</v-fade-transition>
							</v-col>
						</v-row>
					</v-container>
				</v-tab-item>

				<!-- Setup 
				<v-tab-item>
					<v-container>
						<v-row no-gutters class="mb-5">
							<v-col cols="12" align="center">
								<div class="title font-weight-light">Call Control Settings</div>
								<div class="overline grey--text">Step 4 of 4</div>
							</v-col>
						</v-row>
						<v-row justify="center" align="center">
							<v-col cols="4">
								<v-card 
									class="grey lighten-5" 
									height="350">
									<v-row>
										<v-col cols="12" align="center">
											<v-icon color="primary" size="36">mdi-phone-forward</v-icon>
											<div class="title mt-3 font-weight-light">Call Forwarding</div>
											<div class="caption grey--text px-5">
												Ring another phone number when this user is called or route calls based on criteria
											</div>
										</v-col>
									</v-row>
									<v-row>
										<v-col cols="12">
											<v-radio-group dense class="ml-5">
												<v-radio label="Do not forward calls" />
												<v-radio label="Ring another phone number" />
												<v-radio label="Ring another extension" />
											</v-radio-group>
										</v-col>
									</v-row>
								</v-card>
							</v-col>

							<v-col cols="4">
								<v-card 
									class="grey lighten-5" 
									height="350">
									<v-row>
										<v-col cols="12" align="center">
											<v-icon color="primary" size="36">mdi-voicemail</v-icon>
											<div class="title mt-3 font-weight-light">Voicemail</div>
											<div class="caption grey--text px-5">
												Use our system default greeting or record your own by following the steps below
											</div>
										</v-col>
									</v-row>
									<v-row>
										<v-col cols="12">
											<v-radio-group dense class="ml-5">
												<v-radio label="Use system greeting" />
												<v-radio label="Record custom message" />
												<v-radio label="Do not use voicemail" />
											</v-radio-group>
										</v-col>
									</v-row>
								</v-card>
							</v-col>
						</v-row>
						<v-row class="mt-5">
							<v-col cols="2">
								<v-btn text @click="tab--">
									<v-icon left>mdi-arrow-left</v-icon> Back
								</v-btn>
							</v-col>
							<v-col cols="8" align="center">
								<v-btn 
									class="px-5 mb-5 green white--text" 
									@click="save"
									rounded>Save User
								</v-btn>
							</v-col>
						</v-row>
					</v-container>
				</v-tab-item>
				-->
			</v-tabs-items>
			<v-fade-transition>
				<v-btn 
					v-if="tab > 0"
					class="pa-5 ma-5"
					@click="tab--"
					absolute
					bottom
					text
					large>
					<v-icon left>mdi-arrow-left</v-icon>
					Previous
				</v-btn>
			</v-fade-transition>
		</v-card>
	</v-dialog>
</template>

<script>
import PhoneNumber from '@/views/Setup/PhoneNumber'

const model = {
	id: null,
	firstName: '',
	lastName: '',
	extension: '',
	emailAddress: '',
	phoneNumber: null,
	location: null,
	bundle: {
		productId: null,
		name: ''
	},
	phone: []
}

export default {
	components: {
		PhoneNumber
	},
	props: {
		open: Boolean,
		edit: Object
	},
	computed: {
		order() {
			return this.$store.getters.order
		},
		data() {
			return this.$store.getters.data
		},
		bundles() {
			return this.$store.getters.bundles
		},
		phones() {
			return this.$store.getters.phones
		},
		visibleTabs() {
			return this.tabs.filter(item => item.visible === true)
		}
	},
	data() {
		return {
			tab: 0,
			tabs: [
				{ title: 'Profile', visible: true },
				{ title: 'Bundle', visible: true },
				{ title: 'Phone', visible: true }
			],
			users: [],
			user: model,
			catalog: {
				bundles: [],
				phones: []
			},
			rules: {
				required: value => {
					return !!value || 'Required'
				},
				extension: value => {
					const pattern = /^[0-9]*$/

					return (value == '' || value == null ? true : (pattern.test(value) || 'Invalid Extension'))
				},
				email: value => {
					const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

					return (value == '' || value == null ? true : (pattern.test(value) || 'Invalid Email Address'))
				},
				quantity: value => {
					const pattern = /^[0-9]*$/

					return (value == '' || value == null ? true : (pattern.test(value) || 'Error'))
				}
			}
		}
	},
	mounted() {
		this.initialize()
	},
	methods: {
		selectPhone(phone) {
			const index = this.user.phone.findIndex((item) => item.productId === phone.productId)
			const data = (index >= 0 ? { ...this.user.phone[index] } : {})
			const quantity = {
				oldValue: (index >= 0 ? data.quantity : 0),
				value: (phone.assigned == null ? 0 : parseInt(phone.assigned))
			}

			if(quantity.oldValue == 0) {
				this.user.phone.push({
					productId: phone.productId,
					name: phone.name,
					quantity: quantity.value
				})
			}

			else {
				if(quantity.value == 0 && quantity.oldValue > 0) {
					const remove = this.user.phone.findIndex((item) => item.productId === phone.productId)

					if(remove >= 0) {
						this.user.phone.splice(remove, 1)
					}
				}

				else {
					const remove = Object.assign({}, this.user.phone[index])

					this.user.phone[index].quantity = quantity.value
				}
			}
		},
		selectBundle(bundle) {
			if(bundle === null) {
				this.user.bundle = {
					productId: null,
					name: ''
				}

				return false
			}

			const current = Object.assign({}, this.user.bundle)

			if(bundle.productId != current.productId) {
				this.user.bundle = {
					productId: bundle.productId,
					name: bundle.name
				}
			}
		},
		close() {
			this.$emit('close')
		},
		save() {
			if(!this.$refs.profile.validate()) {
				this.tab = 0

				return false
			}

			this.$emit((this.user.id === null ? 'create' : 'update'), this.user)
		},
		back() {
			this.tab--

			if(this.tab < 0) {
				this.close()
			}
		},
		initialize() {
			if(this.$refs.profile != undefined) {
				this.$refs.profile.resetValidation()
			}

			this.tab = 0
			this.user = (this.edit === null ? { ...model, phone: [] } : this.edit)
			this.users = this.data.users
			this.catalog = {
				bundles: this.bundles,
				phones: this.phones
			}

			if(this.catalog.bundles.length == 1) {
				const bundle = this.catalog.bundles[0]

				this.selectBundle(bundle)

				this.tabs[1].visible = false
			}

			else {
				this.tabs[1].visible = true
			}

			if(this.catalog.phones.length == 0) {
				this.tabs[2].visible = false
			}

			else {
				this.tabs[2].visible = true
			}

			if(this.user.phone.length > 0) {
				this.user.phone.forEach(phone => {
					const product = this.catalog.phones.find(item => item.productId === phone.productId)

					if(product) {
						product.assigned = phone.quantity
					}
				})
			}
		}
	},
	watch: {
		open() {
			if(this.open) {
				this.initialize()
			}
		},
		tab() {
			const visible = this.tabs.filter(item => item.visible == true)

			if(this.tab != 0 && this.tab == visible.length) {
				this.save()
			}
		},
		bundles() {
			this.catalog.bundles = this.bundles
		},
		phones() {
			this.catalog.phones = this.phones.map(phone => { 
				return {
					...phone,
					assigned: ''
				}
			})
		}
	}
}
</script>

<style>
.phone .v-badge {
    position: absolute;
    right: 13px;
    top: 13px;
}

.phone .v-badge .v-badge__badge {
    width: 44px;
    height: 44px;
    border-radius: 100%;
    padding-top: 12px;
    font-size: 22px;
}
</style>