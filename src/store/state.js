export const state = {
	id: null,
	accessCode: null,
	activated: false,
	loading: false,
	valid: false,
	theme: {
		dark: true
	},
	catalog: {
		phones: [],
		bundles: [],
		group: []
	},
	data: {
		callingLineId: {
			name: '',
			phoneNumber: ''
		},
		domain: '',
		extensions: {
			digits: 4,
			auto: true,
			used: []
		},
		mainLine: {
			phoneNumber: '',
			autoAttendant: false,
			businessHours: ''
		},
		region: {
			addressLine1: '',
			addressLine2: '',
			city: '',
			country: 'United States',
			state: '',
			timeZone: 'America/New_York',
			zip: ''
		},
		survey: {
			phoneCount: 0,
			phoneNumberCount: 0,
			workFromHomeCount: 0
		},
		users: [],
		ringGroups: []
	},
	order: {
		id: null,
		account: {},
		products: [],
		phoneNumbers: [],
		contact: {
			name: '',
			email: '',
			phoneNumber: ''
		}
	},
	snackbar: {
		position: 'Top Center',
		color: 'blue',
		text: '',
		btn: false,
		visible: false,
		timeout: -1
	}
}