<template>
	<div>
		<Create
			:open="dialog.create.open"
			:edit="dialog.create.data"  
			@close="dialog.create.open = false"
			@create="createGroup($event)"
			@update="updateGroup($event)" />

		<Delete
			:open="dialog.delete.open"
			:group="dialog.delete.data"
			@close="dialog.delete.open = false"
			@delete="deleteGroup($event)" />

		<v-container 
			class="fill-height"
			fluid>
			<v-row>
				<v-col cols="12" align="center">
					<v-icon 
						size="64" 
						color="primary">
						mdi-phone-ring
					</v-icon>
					<div class="my-3">
						<span class="text-h4 font-weight-thin">
							Ring Groups
						</span>
						<div class="text-body-1 text--secondary font-weight-light">
							Increase productivity by distributing incoming calls to multiple users
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
							color="grey lighten-5"
							height="250" 
							@click="setDialog({ create: { open: true, data: null }})"
							hover>
							<v-card-text 
								class="text-center" 
								style="padding-top:50px">
								<v-icon size="72">
									mdi-account-multiple-plus-outline
								</v-icon>
								<div class="text-h5">
									Create Ring Group
								</div>
								<div class="mt-3">
									<v-chip color="green" outlined>
										<span class="text-body-1">
											Unlimited
										</span>
									</v-chip>
								</div>
							</v-card-text>
						</v-card>
					</v-scale-transition>
				</v-col>

				<template v-for="(item, index) in groups">
					<v-col 
						:key="`group-${index}`" 
						cols="3">
						<v-hover v-slot:default="{ hover }">
							<v-badge 
								:content="(index + 1)"
								color="secondary"
								class="card-badge"
								offset-y="20"
								offset-x="20"
								overlap>
								<v-card 
									color="grey lighten-5" 
									height="250">
									<v-card-text style="height:200px">
										<v-list color="transparent">
											<v-list-item>
												<v-list-item-avatar>
													<v-avatar>
														<v-icon 
															size="20" 
															color="primary">
															mdi-star 
														</v-icon>
													</v-avatar>
												</v-list-item-avatar>
												<v-list-item-content>
													<v-list-item-title>
														{{ item.name }}
													</v-list-item-title>
													<v-list-item-subtitle>
														{{ item.users.length }} User(s)
													</v-list-item-subtitle>
												</v-list-item-content>
											</v-list-item>
											<v-list-item>
												<v-list-item-avatar>
													<v-avatar>
														<v-icon 
															size="20" 
															color="primary">
															mdi-phone
														</v-icon>
													</v-avatar>
												</v-list-item-avatar>
												<v-list-item-content>
													<v-list-item-title>
														{{ item.phoneNumber }}
													</v-list-item-title>
													<v-list-item-subtitle>
														Extension {{ item.extension }}
													</v-list-item-subtitle>
												</v-list-item-content>
											</v-list-item>
											<v-list-item>
												<v-list-item-avatar>
													<v-avatar>
														<v-icon 
															size="20" 
															color="primary">
															mdi-bell-ring
														</v-icon>
													</v-avatar>
												</v-list-item-avatar>
												<v-list-item-content>
													<v-list-item-title>
														{{ item.policy }}
													</v-list-item-title>
													<v-list-item-subtitle>
														Call Distribution
													</v-list-item-subtitle>
												</v-list-item-content>
											</v-list-item>
										</v-list>
									</v-card-text>
									<v-card-actions v-if="hover">
										<v-btn 
											class="py-4"
											@click="setDialog({ create: { open: true, data: item }})"
											text
											x-small>
											<v-icon 
												left 
												small>
												mdi-pencil
											</v-icon> 
											Edit
										</v-btn>
										<v-spacer />
										<v-btn 
											class="py-4 d-none"
											color="grey darken-1"
											@click="setDialog({ create: { open: true, data: { ...item, id: null }}})"
											x-small
											text>
											<v-icon 
												left
												small>
												mdi-content-copy
											</v-icon> 
											Copy
										</v-btn>
										<v-spacer />
										<v-btn 
											class="py-4"
											color="red"
											@click="setDialog({ delete: { open: true, data: item }})"
											x-small
											text>
											<v-icon 
												left
												small>
												mdi-trash-can-outline
											</v-icon>
											Delete
										</v-btn>
									</v-card-actions>
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
		order() {
			return this.$store.getters.order
		},
		data() {
			return this.$store.getters.data
		}
	},
	mounted() {
		this.initialize()
	},
	data() {
		return {
			groups: [],
			dialog: {
				create: {
					open: false,
					data: null
				},
				delete: {
					open: false,
					data: null
				}
			}
		}
	},
	methods: {
		save() {
			console.log('Save')

			this.$emit('update', { 
				ringGroups: this.groups 
			})
		},
		createGroup(group) {
			this.dialog.create.open = false

			this.groups.unshift({
				...group,
				id: Date.now()
			})

			this.save()

			this.showSnackbar({ success: 'Ring Group has been created' })
		},
		updateGroup(group) {
			this.dialog.create.open = false

			console.log(group)

			let index = this.groups.findIndex(item => item.id === group.id)
			let response = { error: 'Ring Group failed to update' }

			if(index >= 0) {
				response = { success: 'Ring Group has been updated' }

				this.groups[index] = group

				this.save()
			}

			this.showSnackbar(response)
		},
		deleteGroup(group) {
			const groups = this.groups.filter(item => item.id !== group.id)

			this.showSnackbar({ success: 'Ring group has been deleted' })

			this.dialog.delete.open = false

			this.groups = groups

			this.save()
		},
		setDialog(dialog) {
			for(let key in dialog) {
				this.dialog[key] = {
					...this.dialog[key],
					...dialog[key]
				}
			}
		},
		initialize() {
			this.groups = (Object.prototype.hasOwnProperty.call(this.data, 'ringGroups') ? this.data.ringGroups : [])
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
.v-badge.card-badge .v-badge__badge {
	height: 30px;
	width: 30px;
	border-radius: 30px;
	font-size: 16px;
	line-height: 1.5
}
</style>