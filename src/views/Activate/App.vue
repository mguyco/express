<template>
	<v-main>
		<Dialog 
			:open="dialog.open"
			@close="dialog.open = false" />

		<v-card	
			color="transparent" 
			tile 
			flat>
			<v-card-title class="primary white--text">
				<Toolbar 
					:height="200"
					:title="'Express Setup'" 
					:subtitle="'Design and easily setup your UCx powered system the way you want it'" />
			</v-card-title>
			<v-card-text>
				<v-container class="mt-5">
					<v-row v-if="!loading && !valid" align="center">
						<v-col cols="8" offset="2">
							<v-alert 
								transition="slide-y-transition" 
								type="error" 
								icon="mdi-alert"
								prominent>
								<div class="text-h6">
									This link has expired or is no longer valid
								</div>
								<div class="text-body-1">
									Please reach out to our support team for assistance
								</div>
							</v-alert>
						</v-col>
					</v-row>
					<v-row align="center" justify="center">
						<v-col cols="3">
							<v-card 
								height="240"
								flat>
								<v-card-text class="text-center">
									<v-icon 
										color="info"
										size="128">
										mdi-cog-outline
									</v-icon>
									<div class="text-h4">
										System Settings
									</div>
									<div class="mt-3 text-body-1">
										Setup your calling line identity and configure system settings
									</div>
								</v-card-text>
							</v-card>
						</v-col>
						<v-col cols="1">
							<v-divider style="border-width:1px;margin-bottom:10px" />
						</v-col>
						<v-col cols="3">
							<v-card 
								height="240"
								flat>
								<v-card-text class="text-center">
									<v-icon 
										color="info"
										size="128">mdi-account-group
									</v-icon>
									<div class="text-h4">
										Create Users
									</div>
									<div class="mt-3 text-body-1">
										Add your users and assign phone numbers and extensions
									</div>
								</v-card-text>
							</v-card>
						</v-col>
						<v-col cols="1">
							<v-divider style="border-width:1px;margin-bottom:10px" />
						</v-col>
						<v-col cols="3">
							<v-card 
								height="240"
								flat>
								<v-card-text class="text-center">
									<v-icon 
										color="info"
										size="128">mdi-phone-ring
									</v-icon>
									<div class="text-h4">
										Ring Groups
									</div>
									<div class="mt-3 text-body-1">
										Create user ring groups to distribute incoming calls with multiple options
									</div>
								</v-card-text>
							</v-card>
						</v-col>
					</v-row>
					<v-row class="mt-15">
						<v-col cols="12" align="center">
							<v-btn 
								class="green white--text"
								@click="dialog.open = true"
								:disabled="!valid"
								:loading="loading"
								x-large
								rounded>Lets get started
							</v-btn>
							<div class="mt-5 text-body-1 pt-5 grey--text font-weight-light">
								<div v-if="!activated">
									You will need your Access Code to get started
									<br>
									<v-btn 
										color="primary"
										v-if="valid"  
										small
										text>Resend Access Code
									</v-btn>
								</div>
								<div v-else>
									Your account is active and ready for setup
								</div>
							</div>
						</v-col>
					</v-row>
				</v-container>
			</v-card-text>
		</v-card>
	</v-main>
</template>

<script>
import Toolbar from '@/components/Toolbar'
import Dialog from './Dialog/App'

export default {
	components: {
		Toolbar,
		Dialog
	},
	computed: {
		loading() {
			return this.$store.getters.loading
		},
		valid() {
			return this.$store.getters.valid
		},
		activated() {
			return this.$store.getters.activated
		}
	},
	data() {
		return {
			dialog: {
				open: false
			}
		}
	}
}
</script>