<template>
	<v-dialog
		v-model="open"
		fullscreen>
		<v-card>
			<v-toolbar 
				class="mb-5" 
				color="primary" 
				dark> 
				<v-tooltip bottom>
					<template v-slot:activator="{ on }">
						<v-btn 
							@click="back"
							v-on="on"
							class="mr-5"
							icon>
							<v-icon>
								mdi-arrow-left
							</v-icon>
						</v-btn>
					</template>
					Go back
				</v-tooltip>
				<v-toolbar-title style="width:300px">
					<div>
						<div v-if="group.name == '' || group.name == null">
							Create New Ring Group
						</div>
						<div v-else>
							{{ group.name }}
						</div>
						<div class="text-caption" style="opacity:0.66">
							<div v-if="edit != null">
								Edit Ring Group
							</div>
							<div v-else>
								<div v-if="group.name != '' && group.name != null">
									Create New Ring Group
								</div>
							</div>
						</div>
					</div>
				</v-toolbar-title>
				<v-tabs 
					v-model="tab"
					right>
					<v-tab>
						Profile
					</v-tab>
					<v-tab>
						Users
					</v-tab>
				</v-tabs>
				<v-spacer />
				<v-btn 
					@click="close"
					icon>
					<v-icon>
						mdi-close
					</v-icon>
				</v-btn>
			</v-toolbar>
			<v-tabs-items v-model="tab">
				<!-- Profile -->
				<v-tab-item>
					<v-form ref="profile">
						<v-container fluid>
							<v-row 
								class="mb-5"
								no-gutters>
								<v-col cols="12" align="center">
									<div class="mt-5 text-h5 text--primary font-weight-light">
										Ring Group Profile
									</div>
									<div class="text-body-1 text--secondary">
										All inbound calls to the phone number or extension will ring to the group
									</div>
								</v-col>
							</v-row>
							<v-row 
								class="mt-5" 
								align="center" 
								justify="center">
								<v-col cols="4">
									<div class="text-body-1 text--primary">
										Group Name
									</div>
									<div class="text-body-2 text--secondary">
										Create a name for the ring group
									</div>
								</v-col>
								<v-col cols="4">
									<v-text-field 
										v-model="group.name"
										label="Group Name"
										autofocus 
										outlined />
								</v-col>
							</v-row>
							<v-row 
								align="center" 
								justify="center">
								<v-col cols="4">
									<div class="text-body-1 text--primary">
										Phone Number
									</div>
									<div class="text-body-2 text--secondary">
										Assign a phone number to the ring group
									</div>
								</v-col>
								<v-col cols="4">
									<PhoneNumber 
										:phoneNumberValue="group.phoneNumber" 
										@set="group.phoneNumber = $event" />
								</v-col>
							</v-row>
							<v-row 
								align="center" 
								justify="center">
								<v-col cols="4">
									<div class="text-body-1 text--primary">
										Extension
									</div>
									<div class="text-body-2 text--secondary">
										Assign an extension to the group
									</div>
								</v-col>
								<v-col cols="4">
									<v-text-field 
										v-model="group.extension"
										label="Extension"
										outlined />
								</v-col>
							</v-row>
							<v-row 
								align="center" 
								justify="center">
								<v-col cols="4">
									<div class="text-body-1 text--primary">
										Distribution
									</div>
									<div class="text-body-2 text--secondary">
										Select how calls should be distributed to users
									</div>
								</v-col>
								<v-col cols="4">
									<v-select
										v-model="group.policy"
										:items="policies" 
										item-text="name"
										item-value="name" 
										outlined>
										<template v-slot:item="data">
											<v-list-item-content>
												<v-list-item-title>
													{{ data.item.name }}
												</v-list-item-title>
												<v-list-item-subtitle>
													<div 
														class="d-inline-block text-truncate text-caption grey--text" 
														style="max-width: 780px">
														{{ data.item.description }}
													</div>
												</v-list-item-subtitle>
											</v-list-item-content>
										</template>
									</v-select>
								</v-col>
							</v-row>
							<v-row 
								align="center" 
								justify="center">
								<v-col cols="4">
									<div class="text-body-1 text--primary">
										All User Group
									</div>
									<div class="text-body-2 text--secondary">
										Enable to auto-assign all users to the group (skips next step)
									</div>
								</v-col>
								<v-col cols="4">
									<v-switch />
								</v-col>
							</v-row>
							<v-row 
								class="mt-5" 
								no-gutters>
								<v-col cols="12" align="center">
									<v-btn 
										class="px-5 mb-5 green white--text" 
										@click="tab++"
										rounded
										large>
										Continue
									</v-btn>
								</v-col>
							</v-row>
						</v-container>
					</v-form>
				</v-tab-item>

				<!-- Users -->
				<v-tab-item>
					<v-container fluid>
						<v-row 
							class="mb-5"
							align="end"
							no-gutters>
							<v-col offset="3" cols="6" align="center">
								<v-avatar
									size="72"
									tile>
									<v-img 
										src="https://www.flaticon.com/svg/static/icons/svg/567/567893.svg" />
								</v-avatar>
								<div class="text-h5 text--primary font-weight-light">
									Assign Users
								</div>
								<div class="text-body-1 text--secondary">
									Drag and drop available users into the Ring Group
								</div>
							</v-col>
							<v-col cols="2">
								<v-tooltip
									color="info"
									multiline 
									top>
									<template v-slot:activator="{ on }">
										<v-chip 
											v-on="on" 
											color="info"
											style="cursor:pointer"
											outlined>
											<span class="text-body-1">
												Simultaneous Call Distribution
											</span>
											<v-icon right>
												mdi-pencil
											</v-icon>
										</v-chip>
									</template>
									<div class="text-body-1">
										Alert all users at the same time. The first user to answer handles the call.
									</div>
									<div class="text-body-2" style="opacity:0.77">
										Click to edit
									</div>
								</v-tooltip>
							</v-col>
						</v-row>
						<v-row align="start" justify="center">
							<v-col cols="5">
								<v-card 
									class="available-list"
									height="300"
									flat
									outlined>
									<div class="text-center grey--text text--darken-1 text-h5 pt-5">
										Available Users
									</div>
									<v-card-text>
										<v-list-item-group>
											<Draggable 
												:list="available" 
												group="group" 
												style="min-height: 400px !important">
												<v-list-item 
													v-if="available.length == 0" 
													:style="($vuetify.theme.dark ? 'border:3px dotted rgba(255,255,255,0.15)' : 'border:3px dotted rgba(25,25,25,0.15)')">
													<v-list-item-action>
														<v-icon>
															mdi-account-remove-outline
														</v-icon>
													</v-list-item-action>
													<v-list-item-content>
														<v-list-item-title class="text-body-1 text--primary">
															Drag and drop users here to remove
														</v-list-item-title>
														<v-list-item-subtitle class="text-body-2 text--secondary">
															Place users here to remove them from the Ring Group
														</v-list-item-subtitle>
													</v-list-item-content>
												</v-list-item>
												<v-list-item 
													v-else 
													v-for="user in available" 
													style="cursor:grab !important"
													:key="user.extension"
													:dense="(available.length <= 5 ? false : true)">
													<v-list-item-avatar>
														<v-avatar color="primary">
															<span class="white--text text-body-2">
																{{ user.firstName.charAt(0) + user.lastName.charAt(0) }}
															</span>
														</v-avatar>
													</v-list-item-avatar>
													<v-list-item-content>
														<v-list-item-title class="text-body-1 text--primary">
															{{ user.firstName }} {{ user.lastName }}
														</v-list-item-title>
														<v-list-item-subtitle class="text-body-2 text--secondary">
															Extension {{ user.extension }}
														</v-list-item-subtitle>
													</v-list-item-content>
												</v-list-item>
											</Draggable>
										</v-list-item-group>
									</v-card-text>
								</v-card>
							</v-col>

							<v-col cols="5">
								<v-card 
									class="assigned-list"
									height="300"
									flat
									outlined>
									<div class="text-center pt-5">
										<div class="text-h5 info--text">
											Ring Group
										</div>
									</div>
									<v-card-text>
										<v-list-item-group>
											<Draggable 
												:list="assigned"
												group="group"
												style="min-height:400px !important">
												<v-list-item 
													v-if="assigned.length == 0"
													:style="($vuetify.theme.dark ? 'border:3px dotted rgba(255,255,255,0.15)' : 'border:3px dotted rgba(25,25,25,0.15)')">
													<v-list-item-action>
														<v-icon>mdi-cursor-default-click</v-icon>
													</v-list-item-action>
													<v-list-item-content>
														<v-list-item-title class="text-body-1">
															Drag and drop users here to assign
														</v-list-item-title>
														<v-list-item-subtitle class="text-body-2 text--secondary">
															Sort users by dragging them up or down
														</v-list-item-subtitle>
													</v-list-item-content>
												</v-list-item>
												<v-list-item   
													v-else 
													v-for="(user, index) in assigned" 
													style="cursor:grab !important"
													:key="user.extension"
													:dense="(assigned.length <= 5 ? false : true)">
													<v-list-item-action>
														<v-avatar 
															size="26"
															color="primary"
															class="white--text">
															<span class="text-body-2">
																{{ (index + 1) }}
															</span>
														</v-avatar>
													</v-list-item-action>
													<v-list-item-content>
														<v-list-item-title class="text-body-1 text--primary">
															{{ user.firstName }} {{ user.lastName }}
														</v-list-item-title>
														<v-list-item-subtitle class="text-body-2 text--secondary">
															Extension {{ user.extension }}
														</v-list-item-subtitle>
													</v-list-item-content>
												</v-list-item>
											</Draggable>
										</v-list-item-group>
									</v-card-text>
								</v-card>
							</v-col>
						</v-row>
						<v-row>
							<v-col cols="12" align="center">
								<v-btn 
									class="px-5 my-5 green white--text" 
									@click="tab++"
									v-html="(edit === null ? `Create Ring Group` : `Update Ring Group`)"
									large 
									rounded>
								</v-btn>
							</v-col>
						</v-row>
					</v-container>
				</v-tab-item>
			</v-tabs-items>
		</v-card>
	</v-dialog>
</template>

<script>
import Draggable from 'vuedraggable';
import PhoneNumber from '@/views/Setup/PhoneNumber'

const model = {
	name: '',
	phoneNumber: null,
	extension: null,
	policy: 'Simultaneous',
	users: []
}

export default {
	props: {
		open: Boolean,
		edit: Object
	},
	components: {
		Draggable,
		PhoneNumber
	},
	computed: {
		users() {
			return this.$store.getters.users
		}
	},
	data() {
		return {
			tab: 0,
			group: model,
			assigned: [],
			available: [],
			policies: [
				{
					name: 'Circular',
					description: 'Hunt through users in the order they appear in the list, starting with the user following the last user to receive a call.'
				},
				{
					name: 'Regular',
					description: 'Hunt through users in the order they appear in the list, starting from the top each time.'
				},
				{
					name: 'Simultaneous',
					description: 'Alert all users at the same time. The first user to answer handles the call.'
				},
				{
					name: 'Uniform',
					description: 'Hunt in order, starting with the agent who has been idle the longest and ending with the agent who most recently answered a call.'
				}
			]
		}
	},
	methods: {
		setAvailableUsers(users) {
			this.available = users.map(item => { 
				return {
					id: item.id,
					firstName: item.firstName,
					lastName: item.lastName,
					extension: item.extension
				}
			})
		},
		save() {
			if(!this.$refs.profile.validate()) {
				this.tab = 0

				return false
			}

			this.$emit((this.edit === null ? 'create' : 'update'), {
				...this.group,
				users: this.assigned.map(item => { return item.id })
			})
		},
		close() {
			this.$refs.profile.reset()

			this.assigned = []
			this.available = []

			this.$emit('close')
		},
		back() {
			this.tab--

			if(this.tab < 0) {
				this.close()
			}
		},
		initialize() {
			this.tab = 0
			this.assigned = []

			this.setAvailableUsers(this.users)

			if(this.$refs.profile != undefined) {
				this.$refs.profile.resetValidation()
			}

			this.group = { ...model }

			if(this.edit != null) {
				this.available = []
				this.group = { ...this.edit }

				this.users.forEach(item => {
					const user = {
						id: item.id,
						firstName: item.firstName,
						lastName: item.lastName,
						extension: item.extension
					}

					if(this.group.users.includes(user.id)) {
						this.assigned.push(user)
					}

					else {
						this.available.push(user)
					}
				})
			}
		}
	},
	mounted() {
		this.initialize()
	},
	watch: {
		users() {
			this.setAvailableUsers(this.users)
		},
		open() {
			this.initialize()
		},
		tab() {
			if(this.tab >= 2) {
				this.save()
			}
		}
	}
}
</script>

<style>
.available-list .sortable-chosen {
	border: 2px dashed rgba(25,25,25,0.15) !important;
}

.assigned-list .sortable-chosen {
	border: 2px dashed rgba(90,200,70,0.5) !important;
}
</style>