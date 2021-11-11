import Vue from 'vue'
import Vuex from 'vuex'
import { state } from './state'
import * as types from './mutation-types'

Vue.use(Vuex)

//const debug = process.env.NODE_ENV !== 'production'
const debug = false

const getters = {
	id: state => state.id,
	valid: state => state.valid,
	activated: state => state.activated,
	loading: state => state.loading,
	dark: state => state.theme.dark,
	order: state => state.order,
	account: state => state.order.account,
	catalog: state => state.catalog,
	data: state => state.data,
	bundles: state => state.catalog.bundles,
	phones: state => state.catalog.phones,
	products: state => state.order.products,
	users: state => state.data.users
}

const mutations = {
	[types.UPDATE_PRODUCT_QUANTITY_USED] (state, product) {
		console.log(types.UPDATE_PRODUCT_QUANTITY_USED)
		console.log(product)

		const item = state.catalog[product.catalog].find(item => item.productId === product.productId)
		const quantity = product.quantity

		console.log('Quantity:' + quantity)

		if(item) {
			console.log('Found item in catalog')
			console.log(item)

			if(quantity > 0) {
				item.quantity.used += quantity
			}

			if(quantity < 0) {
				item.quantity.used -= (quantity * -1)
			}

			item.quantity.available = (item.quantity.ordered - item.quantity.used)
		}
	},
	[types.SET_PRODUCT_QUANTITY] (state, product) {
		console.log(types.SET_PRODUCT_QUANTITY)
		console.log(product)

		const item = state.catalog[product.catalog].find(item => item.productId === product.productId)
		const quantity = product.quantity

		if(item) {
			item.quantity.used = quantity.used
			item.quantity.available = quantity.available
			item.quantity.ordered = quantity.ordered

			console.log(state.catalog[product.catalog])
		}
	},
	[types.SHOW_SNACKBAR] (state, snack) {
		console.log(types.SHOW_SNACKBAR)
		console.log(snack)

		for(let key in snack) {
			switch(key) {
				case 'error':
					state.snackbar.color = 'red'
					state.snackbar.btn = true
					state.snackbar.text = snack.error
					state.snackbar.timeout = -1
				break;

				case 'success':
					state.snackbar.color = 'green'
					state.snackbar.btn = false
					state.snackbar.text = snack.success
					state.snackbar.timeout = 3000
				break;

				case 'loading':
					state.snackbar.color = 'blue'
					state.snackbar.btn = false
					state.snackbar.text = 'Loading'
					state.snackbar.timeout = -1
				break;

				default:
					state.snackbar = { 
						...state.snackbar, 
						...snack 
					}
				break;
			}
		}

		state.snackbar.visible = true
	},
	[types.HIDE_SNACKBAR] (state) {
		console.log(types.HIDE_SNACKBAR)

		state.snackbar.visible = false
	},
	[types.SET_STATE] (state, set) {
		console.log(types.SET_STATE)
		console.log(set)

		for(let key in set) {
			if(Object.prototype.hasOwnProperty.call(state, key)) {
				state[key] = set[key]
			}
		}
	},
	[types.SET_DATA] (state, data) {
		console.log(types.SET_DATA)
		console.log(data)

		state.data = data
	}
}

const actions = {
	assignBundle({ commit }, bundle) {
		commit(types.UPDATE_PRODUCT_QUANTITY_USED, { 
			productId: bundle.productId, 
			quantity: 1,
			catalog: 'bundles'
		})
	},
	removeBundle({ commit }, bundle) {
		commit(types.UPDATE_PRODUCT_QUANTITY_USED, { 
			productId: bundle.productId,
			quantity: -1,
			catalog: 'bundles'
		})
	},
	assignPhone({ commit }, phone) {
		commit(types.UPDATE_PRODUCT_QUANTITY_USED, { 
			productId: phone.productId,
			quantity: phone.quantity,
			catalog: 'phones' 
		})
	},
	removePhone({ commit }, phone) {
		commit(types.UPDATE_PRODUCT_QUANTITY_USED, { 
			productId: phone.productId,
			quantity: (phone.quantity * -1),
			catalog: 'phones' 
		})
	},
	setProductQuantity({ commit }, product) {
		commit(types.SET_PRODUCT_QUANTITY, product)
	},
	showSnackbar({ commit }, snack) {
		commit(types.SHOW_SNACKBAR, snack)
	},
	hideSnackbar({ commit }) {
		commit(types.HIDE_SNACKBAR)
	},
	setData({ commit}, data) {
		commit(types.SET_DATA, data)
	},
	setState({ commit }, payload) {
		commit(types.SET_STATE, payload)
	}
}

export default new Vuex.Store({
	state,
	strict: debug,
	getters,
	actions,
	mutations
})