<template>
	<transition name="fade" mode="out-in">
		<router-view />
	</transition>
</template>

<script>
export default {
	computed: {
		id() {
			return this.$store.getters.id
		},
		catalog() {
			return this.$store.getters.catalog
		},
		data() {
			return this.$store.getters.data
		}
	},
	mounted() {
		this.setState({
			id: this.$route.params.id,
			activated: false,
			valid: false,
			loading: true
		})

		this.showSnackbar({ loading: true })

		const express = this.getJSON(this.id)
		const catalog = this.catalog
		const data = this.data

		const request = this.API('validate', 'id=' + this.id)
		.then(response => {
			this.hideSnackbar()

			if(this.getProp(response, 'account')) {
				this.setState({
					valid: true,
					catalog: {
						...catalog,
						...response.catalog
					},
					order: {
						id: response.orderId,
						account: response.account,
						products: response.products,
						phoneNumbers: response.phoneNumbers,
						contact: {
							name: response.account.contactName,
							email: response.account.contactEmail,
							phoneNumber: response.account.contactPhone
						}
					}
				})

				this.setData({
					...data,
					domain: response.account.domain,
					region: {
						...data.region,
						addressLine1: response.account.addressLine1,
						addressLine2: response.account.addressLine2,
						city: response.account.city,
						state: response.account.state,
						zip: response.account.zipCode
					}
				})

				if(this.getProp(response, 'activatedOnDate')) {
					if(response.activatedOnDate != '') {
						this.setState({ activated: true })
					}

					else {
						if(this.$route.name != 'Activate') {
							this.$router.replace({ 
								path: '/' + this.id + '/activate'
							})
						}
					}
				}

				if(this.getProp(express, 'data')) {
					this.setData({ 
						...data,
						...express.data 
					})

					express.data.users.forEach(user => {
						this.assignBundle(user.bundle)

						user.phone.forEach(phone => this.assignPhone(phone))
					})
				}

				this.saveJSON(this.id, {
					...express,
					catalog: this.$store.getters.catalog,
					data: this.$store.getters.data,
					order: this.$store.getters.order
				})
			}
		})
		.catch(error => this.showSnackbar({ 
			error: 'Looks like we lost connection. Please try reloading the page.' 
		}))

		request.then(() => this.setState({ loading: false }))
	}
}
</script>