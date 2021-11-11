<template>
	<div>
		<Create
			:open="dialog.create.open"
			:edit="dialog.create.data"
			@close="dialog.create.open = false"
			@create="createUser($event)"
			@update="updateUser($event)" />
	
		<Delete
			:open="dialog.delete.open"
			:user="dialog.delete.data"
			@close="dialog.delete.open = false"
			@delete="deleteUser($event)" />

		<v-container 
			class="fill-height"
			fluid>
			<v-row>
				<v-col cols="12" align="center">
					<v-icon 
						size="64" 
						color="primary">
						mdi-account-group
					</v-icon>
					<div class="my-3">
						<span class="text-h4 font-weight-thin">
							Setup Users
						</span>
						<div class="text-body-1 text--secondary font-weight-light">
							Assign phone numbers, extensions and basic profile details
						</div>
					</div>
				</v-col>
			</v-row>
			<v-row 
				justify="center" 
				align="center"
				class="mt-3">
				<v-col cols="3">
					<v-scale-transition>
						<v-card 
							:color="($vuetify.theme.dark ? '' : 'grey lighten-5')"
							height="250" 
							transition=""
							@click="setDialog({ create: { open: true, data: null }})"
							hover>
							<v-card-text 
								class="text-center" 
								style="padding-top:50px">
								<v-icon size="72">
									mdi-account-plus
								</v-icon>
								<div class="text-h5">
									Create New User
								</div>
								<div class="mt-3">
									<v-chip color="green" outlined>
										<span class="text-body-1">
											{{ getQuantity('available', bundles) }} Available
										</span>
									</v-chip>
								</div>
							</v-card-text>
						</v-card>
					</v-scale-transition>
				</v-col>

				<template v-for="(item, index) in users">
					<v-col
						:key="`user-${index}`" 
						cols="3">
						<v-hover>
							<v-badge 
								:content="(index + 1)"
								color="green"
								class="user-badge"
								offset-y="20"
								offset-x="20"
								overlap>
								<v-card 
									color="grey lighten-5"
									height="250"
									width="300"
									@click="setDialog({ create: { open: true, data: item }})">
									<v-card-text style="height:200px">
										<v-list color="transparent">
											<v-list-item>
												<v-list-item-avatar>
													<v-avatar>
														<v-icon color="primary">
															mdi-account
														</v-icon>
													</v-avatar>
												</v-list-item-avatar>
												<v-list-item-content>
													<v-list-item-title class="text-body-1 text--primary">
														{{ item.firstName }} {{ item.lastName }}
													</v-list-item-title>
													<v-list-item-subtitle class="text-body-2 text--secondary">
														{{ item.bundle.name }}
													</v-list-item-subtitle>
												</v-list-item-content>
											</v-list-item>
											<v-list-item>
												<v-list-item-avatar>
													<v-icon color="primary">
														mdi-dialpad
													</v-icon>
												</v-list-item-avatar>
												<v-list-item-content v-if="item.phoneNumber != null">
													<v-list-item-title class="text-body-1 text--primary">
														{{ item.phoneNumber }}
													</v-list-item-title>
													<v-list-item-subtitle class="text-body-2 text--secondary">
														Extension {{ item.extension }}
													</v-list-item-subtitle>
												</v-list-item-content>
												<v-list-item-content v-else>
													<v-list-item-title class="text-body-1 text--primary">
														Extension {{ item.extension }}
													</v-list-item-title>
												</v-list-item-content>
											</v-list-item>
											<v-list-item v-if="item.phone.length > 0">
												<v-list-item-action v-if="item.phone[0].quantity > 1">
													<v-badge
														:content="item.phone[0].quantity"
														color="secondary">
														<v-icon color="primary">
															mdi-phone-classic
														</v-icon>
													</v-badge>
												</v-list-item-action>
												<v-list-item-avatar v-else>
													<v-icon color="primary">
														mdi-phone-classic
													</v-icon>
												</v-list-item-avatar>
												<v-list-item-content>
													<v-list-item-title class="text-body-1 text--primary">
														{{ item.phone[0].name }}
													</v-list-item-title>
													<v-list-item-subtitle v-if="item.phone.length > 1">
														<span class="text-body-2 text--secondary">
															+{{ (item.phone.length - 1) }} other model
														</span>
													</v-list-item-subtitle>
												</v-list-item-content>
											</v-list-item>
											<v-list-item v-if="item.phone.length == 0 && item.emailAddress != ''">
												<v-list-item-avatar>
													<v-icon color="primary">
														mdi-voicemail
													</v-icon>
												</v-list-item-avatar>
												<v-list-item-content>
													<v-list-item-title class="text-body-1 text--primary">
														{{ item.emailAddress }}
													</v-list-item-title>
												</v-list-item-content>
											</v-list-item>
										</v-list>
									</v-card-text>
									<!--
									<v-card-actions v-if="hover">
										<v-btn 
											color="orange"
											@click="setDialog({ create: { open: true, data: item }})"
											outlined
											rounded
											small>
											<v-icon 
												left 
												small>
												mdi-pencil
											</v-icon> 
											Modify
										</v-btn>
										<v-spacer />
										<v-btn 
											color="red"
											@click="setDialog({ delete: { open: true, data: item }})"
											outlined
											rounded
											small>
											<v-icon 
												left
												small>
												mdi-trash-can-outline
											</v-icon>
											Delete
										</v-btn>
									</v-card-actions>
								-->
								</v-card>
							</v-badge>
						</v-hover>
					</v-col>
				</template>
			</v-row>
		</v-container>
	</div>
</template>

<script>
import Create from './Create/App'
import Delete from './Delete/App'

export default {
	components: {
		Create,
		Delete
	},
	computed: {
		bundles() {
			return this.$store.getters.bundles
		},
		phones() {
			return this.$store.getters.phones
		},
		data() {
			return this.$store.getters.data
		}
	},
	data() {
		return {
			users: [],
			dialog: {
				delete: {
					open: false,
					data: null
				},
				create: {
					open: false,
					data: null
				}
			}
		}
	},
	mounted() {
		this.initialize()
	},
	methods: {
		save() {
			console.log('Save')

			this.assignUserProducts()

			this.$emit('update', { 
				users: this.users 
			})
		},
		setDialog(dialog) {
			for(let key in dialog) {
				if(Object.prototype.hasOwnProperty.call(this.dialog, key)) {
					this.dialog[key] = {
						...this.dialog[key],
						...dialog[key]
					}
				}
			}
		},
		copyUser(user) {
			
		},
		createUser(user) {
			console.log('Create User')

			this.dialog.create.open = false

			this.users.unshift({
				...user,
				id: Date.now()
			})

			this.save()
		},
		updateUser(user) {
			console.log('Update User ' + user.id)

			this.dialog.create.open = false

			let index = this.users.findIndex((item) => item.id === user.id)
			let response = { error: 'User not updated' }

			if(index >= 0) {
				response = { success: 'User has been updated' }

				this.users[index] = user

				this.save()
			}

			this.showSnackbar(response)
		},
		deleteUser(user) {
			console.log('Delete User ' + user.id)

			const users = this.users.filter(item => item.id !== user.id)

			if(user.phone.length > 0) {
				user.phone.forEach(phone => this.removePhone(phone))
			}

			this.removeBundle(user.bundle)

			this.showSnackbar({ success: 'User has been deleted' })

			this.dialog.delete.open = false

			this.users = users

			this.save()
		},
		resetUserProducts() {
			this.bundles.forEach(bundle => {
				const total = bundle.quantity.ordered

				this.setProductQuantity({
					catalog: 'bundles',
					productId: bundle.productId,
					quantity: {
						available: total,
						ordered: total,
						used: 0
					}
				})
			})

			this.phones.forEach(phone => {
				const total = phone.quantity.ordered

				this.setProductQuantity({
					catalog: 'phones',
					productId: phone.productId,
					quantity: {
						available: total,
						ordered: total,
						used: 0
					}
				})
			})
		},
		assignUserProducts() {
			this.resetUserProducts()

			this.users.forEach(user => {
				user.phone.forEach(phone => this.assignPhone(phone))

				this.assignBundle(user.bundle)
			})
		},
		initialize() {
			this.users = (Object.prototype.hasOwnProperty.call(this.data, 'users') ? this.data.users : [])
			//this.users.reverse()
		}
	},
	watch: {
		data() {
			this.initialize()
		}
	}
}
</script>

<style>
.v-badge.user-badge .v-badge__badge {
	height: 30px;
	width: 30px;
	border-radius: 30px;
	font-size: 16px;
	line-height: 1.5
}
</style>