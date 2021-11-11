<template>
	<div v-if="!resend">
		<v-row no-gutters>
			<v-col cols="12" align="center">
				<div class="mb-1 text-h6">
					<span v-if="error == ''">Activation Required</span>
					<span v-else class="red--text">{{ error }}</span>
				</div>
				<div class="text-body-2">
					Please enter your Access Code and click continue
				</div>
				<v-btn
					color="primary"
					@click="resend = true"
					x-small
					text>
					Resend Access Code
				</v-btn>
			</v-col>
		</v-row>
		<v-row class="mt-3" justify="center" align="center">
			<v-col cols="6" align="center">
				<v-text-field 
					v-model="$store.state.accessCode" 
					prepend-inner-icon="mdi-lock" 
					label="Access Code"
					:loading="$store.state.loading"
					:error="(error == '' ? false : true)"
					autofocus
					outlined
					solo />
			</v-col>
		</v-row>
	</div>
	<div v-else>
		<v-row no-gutters>
			<v-col cols="12" align="center">
				<div class="mb-1 text-h6">
					<span v-if="error == ''">Reset Activation Code</span>
					<span v-else class="red--text">{{ error }}</span>
				</div>
				<div class="text-body-2">
					Please enter your Email Address and click continue
				</div>
				<v-btn
					color="primary"
					@click="resend = false"
					x-small
					text>
					Enter Access Code
				</v-btn>
			</v-col>
		</v-row>
		<v-row class="mt-3" justify="center" align="center">
			<v-col cols="8" align="center">
				<v-text-field 
					v-model="email" 
					prepend-inner-icon="mdi-email" 
					label="Email Address"
					:loading="$store.state.loading"
					:error="(error == '' ? false : true)"
					autofocus
					outlined
					solo />
			</v-col>
		</v-row>
	</div>
</template>

<script>
export default {
	props: {
		error: String,
		open: Boolean
	},
	data() {
		return {
			resend: false,
			email: ''
		}
	},
	watch: {
		open: function() {
			this.$store.state.accessCode = null
			this.resend = false
		},
		resend: function() {
			this.$emit('setError', '')
		}
	}
}
</script>