<template>
	<div>
		<v-dialog
			v-model="dialog.notReady"
			overlay-opacity="0.9"
			width="690">
			<v-card class="pa-3">
				<v-card-title>
					<span class="text-h5 text--primary">
						Take your time
					</span>
					<v-spacer />
					<v-avatar 
						size="72" 
						tile>
						<v-img src="https://image.flaticon.com/icons/svg/3063/3063835.svg" />
					</v-avatar>
				</v-card-title>
				<v-card-text class="text-body-1">
					You may stop and resume Express Setup at anytime.
					<br>
					We recommend bookmarking or saving the link below for convenience.
					<br>
					<br>
					<v-text-field 
						id="copy-text"
						:value="`https://express.tpx.com/${id}/activate`" 
						readonly
						outlined 
						solo 
						flat />
				</v-card-text>
				<v-card-actions>
					<v-btn 
						color="grey darken-1"
						@click="copy" 
						outlined
						rounded 
						small 
						text>
						<v-icon left small>
							mdi-content-copy
						</v-icon>
						Copy Link
					</v-btn>
					<v-spacer />
					<v-btn 
						color="primary" 
						@click="dialog.notReady = false"
						text>
						Close
					</v-btn>
				</v-card-actions>
			</v-card>
		</v-dialog>

		<div class="mt-3 text-center">
			<v-icon 
				size="64" 
				color="grey lighten-1">
				mdi-text-box-check
			</v-icon>
			<div class="mt-2 text-h5 text--primary">
				Before we begin
			</div>
			<div class="text-body-2 text--secondary">
				You will be asked to fill out the information listed below
			</div>
		</div>
		<v-row class="my-3">
			<v-col cols="12">
				<v-list 
					color="white" 
					three-line>
					<v-list-item>
						<v-list-item-avatar>
							<v-avatar color="primary">
								<v-icon dark>mdi-account</v-icon>
							</v-avatar>
						</v-list-item-avatar>
						<v-list-item-content>
							<v-list-item-title>Users</v-list-item-title>
							<v-list-item-subtitle>
								First, last names of your users, bundle features, desk phone and phone number
							</v-list-item-subtitle>
						</v-list-item-content>
					</v-list-item>
					<v-list-item>
						<v-list-item-avatar>
							<v-avatar color="primary">
								<v-icon dark>mdi-dialpad</v-icon>
							</v-avatar>
						</v-list-item-avatar>
						<v-list-item-content>
							<v-list-item-title>Extensions</v-list-item-title>
							<v-list-item-subtitle>
								How many digits for extension dialing and assigning extensions to your users
							</v-list-item-subtitle>
						</v-list-item-content>
					</v-list-item>
					<v-list-item>
						<v-list-item-avatar>
							<v-avatar color="primary">
								<v-icon dark>mdi-phone-in-talk</v-icon>
							</v-avatar>
						</v-list-item-avatar>
						<v-list-item-content>
							<v-list-item-title>Main Line</v-list-item-title>
							<v-list-item-subtitle>
								How your main company phone line should operate and how incoming calls will be answered
							</v-list-item-subtitle>
						</v-list-item-content>
					</v-list-item>
				</v-list>
			</v-col>
		</v-row>
		<v-row no-gutters>
			<v-col cols="12" align="center">
				<v-btn
					color="primary"
					@click="dialog.notReady = true"
					small
					text>
					what if I am not ready?
				</v-btn>
				<v-divider class="my-3" style="width:70%" />
			</v-col>
		</v-row>

	</div>
</template>

<script>
export default {
	computed: {
		id() {
			return this.$store.getters.id
		}
	},
	data() {
		return {
			dialog: {
				notReady: false
			}
		}
	},
	methods: {
		copy() {
			const text = document.querySelector('#copy-text')

			text.select()

			document.execCommand('copy')

			this.showSnackbar({
				color: 'grey',
				text: 'Copied link to clipboard',
				timeout: 3000,
				btn: false
			})
		}
	}
}
</script>

<style>
#copy-text:hover {
	color: #1976d2 !important;
	cursor: default;
}
</style>