import { mapActions } from 'vuex'

const actions = { 
	...mapActions(['showSnackbar']),
	...mapActions(['hideSnackbar']),
	...mapActions(['setState']),
	...mapActions(['setData']),
	...mapActions(['setProductQuantity']),
	...mapActions(['assignBundle']),
	...mapActions(['assignPhone']),
	...mapActions(['removePhone']),
	...mapActions(['removeBundle'])
}

export default {
	methods: { 
		...actions,

		async API(endpoint, body, method) {
			//const url = 'http://10.8.4.37/express/api/?endpoint=' + endpoint
			const url = 'https://mguy.000webhostapp.com/express/api/?endpoint=' + endpoint
			const serialize = ['POST','PUT','PATCH','DELETE']
			const options = { 
				method: (typeof method === 'undefined' ? 'GET' : method)
			}

			if(method == 'FILE') {
				options.method = 'POST'
				options.body = body
			}

			if(serialize.includes(method)) {
				options.body = JSON.stringify(body)
			}

			let response = await fetch(url + (typeof body === 'string' ? '&' + body : ''), options)
			let data = await response.json()

			return data
		},
		getJSON(id) {
			const response = localStorage.getItem('TPX_EXPRESS_' + id)

			return (response === null ? {} : JSON.parse(response))
		},
		saveJSON(id, data) {
			console.log('saveJSON: ' + id)
			console.log(data)

			if(id == null) return false

			localStorage.setItem('TPX_EXPRESS_' + id, JSON.stringify(data))
		},
		getProp(data, prop) {
			return Object.prototype.hasOwnProperty.call(data, prop)
		},
		getQuantity(key, items) {
			let total = 0

			if(items !== undefined) {
				items.forEach(item => total += item.quantity[key])
			}

			if(total == 0) {
				total = '0';
			}

			return total
		}
	}
}