<template>
	<v-dialog 
		overlay-color="primary" 
		overlay-opacity="0.9" 
		v-model="open"  
		width="520"
		persistent>
		<v-card class="pa-5">
			<v-card-text>
				<v-row>
					<v-col cols="12" align="center">
						<v-img 
							width="190" 
							src="http://192.168.109.53/express/img/tpx-express-logo.png" />
						<v-btn 
							style="position:absolute;right:10px;top:10px" 
							@click="$emit('close')"
							icon>
							<v-icon>mdi-close</v-icon>
						</v-btn>
					</v-col>
				</v-row>
				<v-tabs v-model="tab">
					<!-- Form -->
					<v-tab-item>
						<Form 
							:error="error" 
							:open="open" 
							@setError="error = $event" />
					</v-tab-item>

					<!-- Response -->
					<v-tab-item>
						<Response />
					</v-tab-item>

					<!-- Checklist -->
					<v-tab-item>
						<Checklist />
					</v-tab-item>
				</v-tabs>
				<v-row>
					<v-col cols="12" align="center">
						<v-btn
							color="green"
							@click="tab++"
							:disabled="$store.state.loading"
							dark
							large 
							rounded>{{ btn }}
						</v-btn>
					</v-col>
				</v-row>
			</v-card-text>
		</v-card>
	</v-dialog>
</template>

<script>
import Form from './Form'
import Response from './Response'
import Checklist from './Checklist'

export default {
	props: {
		open: Boolean
	},
	components: {
		Form,
		Response,
		Checklist
	},
	data() {
		return {
			tab: 0,
			error: '',
			btn: 'Continue',
		}
	},
	mounted() {

	},
	methods: {
		activate() {
			this.tab = 0

			if(this.$store.state.accessCode == null) return false

			this.$store.state.loading = true

			const request = this.API('activate', { 
				id: this.$store.state.id,
				accessCode: this.$store.state.accessCode
			}, 'POST')
			.then(data => {
				if(Object.prototype.hasOwnProperty.call(data, 'success')) {
					this.$store.state.activated = true

					this.tab = 1;
				}

				if(Object.prototype.hasOwnProperty.call(data, 'error')) {
					this.error = data.error
				}
			})
			.catch(error => this.showSnackbar({ error: error }))

			request.then(() => {
				this.$store.state.loading = false
			})
		}
	},
	watch: {
		open: function() {
			this.tab = 0
			this.error = ''
			this.$store.state.accessCode = null

			if(this.$store.state.activated) {
				this.tab = 2
			}
		},
		tab: function() {
			this.btn = (this.tab == 2 ? 'Start Express Setup' : 'Continue')

			if(this.$store.state.activated) {
				if(this.tab == 3) {
					this.$router.push({ path: './questions' })
				}
			}

			else {
				if(this.tab == 1) {
					this.activate()
				}
			}
		}
	}
}
</script>

<style>
.v-dialog svg {
	margin-top: 5px;
	width: 96px;
	margin: 3px;
	height: auto;
}

.v-dialog .v-tabs-bar {
	display: none;
}
</style>