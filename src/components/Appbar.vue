<template>
	<v-app-bar 
		:color="($vuetify.theme.dark ? '' : 'primary')"
		transition="slide-x-reverse-transition"  
		clipped-left 
		dark 
		app>
		<v-app-bar-nav-icon />
		<v-toolbar-title>
			<!--
			<svg width="216px" height="81px" viewBox="0 0 216 81">
				<g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
					<g transform="translate(-303.000000, -17.000000)">
						<g>
							<g transform="translate(303.000000, 19.000000)">
								<g>
									<path d="M133.896163,37.0756147 C132.40809,19.4053937 116.366837,19.3887621 115.003464,19.4228568 L68.8008976,19.4228568 L68.8008976,31.6645305 L112.495355,31.6645305 C115.448223,31.6645305 117.625464,32.3929937 118.968054,33.8299621 C120.741271,35.7276253 120.584151,38.3853516 120.583319,38.3961621 L120.576669,38.5682989 C120.576669,40.4568147 120.054596,41.8754884 118.980524,42.9066463 C116.79497,45.0038884 113.007452,44.8741621 112.974199,44.8724989 L68.8008976,44.8700042 L68.8008976,77.7672674 L81.9366687,77.7672674 L81.9366687,57.1100147 L110.757054,57.0967095 C116.740102,57.0967095 119.104392,56.5902779 119.997235,56.2717832 C135.459886,52.7408989 134.075729,38.5009411 133.896163,37.0756147" fill="#fff"></path>
									<polygon fill="#fff" points="0 19.4232726 0.0748192771 31.6641147 25.8999398 31.6641147 25.8999398 77.7668516 39.0357108 77.7668516 39.0357108 31.6641147 64.9123735 31.6641147 64.9722289 19.4232726"></polygon>
									<polygon fill="#fff" points="168.815899 37.9770463 187.755983 19.0070674 169.155911 19.0070674 159.45767 28.8296779 149.742802 19.0070674 131.089525 19.0070674 150.04873 38.0244463 109.518296 78.3019726 128.401019 78.3019726 159.373706 47.1027937 169.768598 57.5124989 188.451802 57.5124989"></polygon>
									<g transform="translate(172.915663, 13.438981)">
										<polygon fill="#fff" points="2.98678554 0.181866316 0.501122892 2.74146632 15.5605807 2.74146632 18.0828217 0.181866316"></polygon>
										<polygon stroke="#fff" stroke-width="3" points="2.98678554 0.181866316 0.501122892 2.74146632 15.5605807 2.74146632 18.0828217 0.181866316"></polygon>
									</g>
									<g transform="translate(179.566265, 6.786349)">
										<polygon fill="#fff" points="2.54676506 0.220867368 0.0619337349 2.78046737 15.1213916 2.78046737 17.6436325 0.220867368"></polygon>
										<polygon stroke="#fff" stroke-width="3" points="2.54676506 0.220867368 0.0619337349 2.78046737 15.1213916 2.78046737 17.6436325 0.220867368"></polygon>
									</g>
									<g transform="translate(185.385542, 0.133718)">
										<polygon fill="#fff" points="2.87231205 0.282237895 0.386649398 2.84183789 15.4461072 2.84183789 17.9683482 0.282237895"></polygon>
										<polygon stroke="#fff" stroke-width="3" points="2.87231205 0.282237895 0.386649398 2.84183789 15.4461072 2.84183789 17.9683482 0.282237895"></polygon>
									</g>
								</g>
							</g>
						</g>
					</g>
				</g>
			</svg>
		-->
			<v-avatar 
				size="48" 
				class="mr-1"
				tile>
				<v-img src="https://i.ibb.co/Y34pYRB/3049618.png" />
			</v-avatar>
			<span class="text-caption pl-3 white--text" style="position:absolute;top:44px;opacity:0.66">
				Powered by VueJS
			</span>
			<span class="text-h4 font-weight-light" style="letter-spacing: 2px !important">
				Express Setup
			</span>
		</v-toolbar-title>
		<v-spacer />
		<div class="mr-5">
			<!-- bundles -->
			<v-fade-transition v-if="valid">
				<v-menu 
					min-width="320"
					max-width="480" 
					transition="slide-x-transition" 
					offset-y 
					open-on-hover>
					<template v-slot:activator="{ on }">
						<v-badge 
							color="green" 
							offset-x="30" 
							offset-y="28" 
							:content="getQuantity('available', bundles)"
							overlap>
							<v-btn  
								class="white--text text-body-2"
								style="text-transform:unset"
								v-on="on"
								text>
								Bundles
								<v-icon right>
									mdi-menu-down
								</v-icon>
							</v-btn>
						</v-badge>
					</template>
					<v-list>
						<v-subheader>
							User Bundles
						</v-subheader>
						<template v-for="(item, index) in bundles">
							<v-list-item 
								:key="`bundle-${index}`">
								<v-list-item-avatar>
									<v-avatar tile size="28">
										<img :src="item.image">
									</v-avatar>
								</v-list-item-avatar>
								<v-list-item-content>
									<v-list-item-title>
										{{ item.name }}
									</v-list-item-title>
									<v-list-item-subtitle>
										{{ item.description }}
									</v-list-item-subtitle>
									<v-list-item-subtitle class="pt-1">
										<v-chip 
											color="green"
											small
											dark>
											{{ item.quantity.available }} Available 
										</v-chip>
										<v-chip 
											class="ml-2" 
											color="primary"
											small
											dark>
											{{ item.quantity.used }} Used 
										</v-chip>
									</v-list-item-subtitle>
								</v-list-item-content>
							</v-list-item>
							<v-divider 
								v-if="index != (bundles.length - 1)"
								:key="`bundle-divider-${index}`"
								style="width:75% !important"
								inset />
						</template>
					</v-list>
				</v-menu>
			</v-fade-transition>

			<!-- phones -->
			<v-fade-transition v-if="valid && phones.length > 0">
				<v-menu 
					min-width="320"
					max-width="480"  
					transition="slide-x-transition" 
					offset-y 
					open-on-hover>
					<template v-slot:activator="{ on }">
						<v-badge
							color="green" 
							offset-x="30"
							offset-y="28"
							:content="getQuantity('available', phones)"
							overlap>
							<v-btn 
								:disabled="!$store.state.valid" 
								class="white--text text-body-2"
								style="text-transform:unset"
								v-on="on"
								text>
								Phones
								<v-icon right>
									mdi-menu-down
								</v-icon>
							</v-btn>
						</v-badge>
					</template>
					<v-list>
						<v-subheader>
							Business Phones
						</v-subheader>
						<template v-for="(item, index) in phones">
							<v-list-item :key="`phone-${index}`">
								<v-list-item-avatar>
									<v-avatar tile size="28">
										<img :src="item.image">
									</v-avatar>
								</v-list-item-avatar>
								<v-list-item-content>
									<v-list-item-title>
										{{ item.name }}
									</v-list-item-title>
									<v-list-item-subtitle>
										{{ item.description }}
									</v-list-item-subtitle>
									<v-list-item-subtitle class="pt-1">
										<v-chip 
											color="green"
											small
											dark>
											{{ item.quantity.available }} Available 
										</v-chip>
										<v-chip 
											class="ml-2" 
											color="primary"
											small
											dark>
											{{ item.quantity.used }} Used 
										</v-chip>
									</v-list-item-subtitle>
								</v-list-item-content>
							</v-list-item>
						</template>
					</v-list>
				</v-menu>
			</v-fade-transition>

			<!-- order -->
			<v-fade-transition v-if="valid">
				<v-menu 
					transition="slide-x-transition"
					min-width="380"
					max-width="380"  
					offset-y 
					open-on-hover>
					<template v-slot:activator="{ on }">
						<v-btn 
							:disabled="!valid" 
							class="white--text text-body-2"
							style="text-transform:unset"
							v-on="on"
							text>
							Order {{ order.account.orderID }}
							<v-icon right>
								mdi-menu-down
							</v-icon>
						</v-btn>
					</template>
					<v-card>
						<v-list class="pl-2 pb-5 transparent">
							<v-subheader>
								Customer Account
							</v-subheader>
							<v-list-item>
								<v-list-item-avatar>
									<v-avatar 
										size="32"
										tile>
										<img src="https://i.ibb.co/HPf6m37/3562140.png">
									</v-avatar>
								</v-list-item-avatar>
								<v-list-item-content>
									<v-list-item-title class="text-body-1">
										{{ account.customerParentName }}
									</v-list-item-title>
									<v-list-item-subtitle>
										<span v-if="account.newCustomer == true" class="green--text">
											New Customer
										</span>
										<span v-else class="text--secondary">
											Existing Customer
										</span>
									</v-list-item-subtitle>
								</v-list-item-content>
							</v-list-item>
							<v-divider class="px-5 mx-5 mt-2" />
							<v-subheader>
								Service Location
							</v-subheader>
							<v-list-item>
								<v-list-item-avatar>
									<v-avatar 
										size="32"
										tile>
										<img src="https://i.ibb.co/rQZZ1cc/869161.png">
									</v-avatar>
								</v-list-item-avatar>
								<v-list-item-content>
									<v-list-item-title>
										{{ account.addressLine1 }}
									</v-list-item-title>
									<v-list-item-subtitle>
										{{ account.city }}, {{ account.stateAbbr }} {{ account.zipCode }}
									</v-list-item-subtitle>
								</v-list-item-content>
							</v-list-item>
							<v-divider class="px-5 mx-5 mt-2" />
							<v-subheader>
								Technical Support
							</v-subheader>
							<v-list-item>
								<v-list-item-avatar>
									<v-avatar 
										size="32"
										tile>
										<img src="https://i.ibb.co/nnN96CT/2838614.png">
									</v-avatar>
								</v-list-item-avatar>
								<v-list-item-content>
									<v-list-item-title>
										Mike Guy
									</v-list-item-title>
									<v-list-item-subtitle>
										(978) 457-4404
									</v-list-item-subtitle>
									<v-list-item-subtitle>
										mguy.co@gmail.com
									</v-list-item-subtitle>
								</v-list-item-content>
								<v-list-item-action>
									<v-tooltip left>
										<template v-slot:activator="{ on }">
											<v-btn 
												v-on="on" 
												class="mr-2"
												color="primary" 
												icon>
												<v-icon>
													mdi-message-text
												</v-icon>
											</v-btn>
										</template>
										<span>Send a message</span>
									</v-tooltip>
									<v-list-item-action-text>
										Message
									</v-list-item-action-text>
								</v-list-item-action>
							</v-list-item>
						</v-list>
						<div class="pb-5 text-center">
							<v-tooltip 
								color="primary darken-2"
								bottom>
								<template v-slot:activator="{ on }">
									<v-btn
										color="primary"
										v-on="on"
										outlined
										rounded>
										View Order {{ order.account.orderID }} 
									</v-btn>
								</template>
								<span class="text-body-1">
									Click here to view order in the Customer Portal
								</span>
							</v-tooltip>
						</div>
					</v-card>
				</v-menu>
			</v-fade-transition>
		</div>
		<v-progress-linear
			color="white"
			buffer-value="0"
			:active="loading"
			stream
			absolute
			bottom />
	</v-app-bar>
</template>

<script>
export default {
	computed: {
		valid() {
			return this.$store.getters.valid
		},
		loading() {
			return this.$store.getters.loading
		},
		order() {
			return this.$store.getters.order
		},
		account() {
			return this.$store.getters.account
		},
		data() {
			return this.$store.getters.data
		},
		phones() {
			return this.$store.getters.phones
		},
		bundles() {
			return this.$store.getters.bundles
		}
	}
}
</script>

<style>
.v-toolbar .v-toolbar__title svg {
	position: absolute;
	top: 19px;
	left: 29px;
	width: 62px;
	height: auto;
}

.v-toolbar .v-toolbar__title span {
	margin-left: 6px;
}

.v-toolbar .v-toolbar__content .v-badge .v-badge__badge {
    border-radius: 100%;
}
</style>