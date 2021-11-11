export const questions = [
	{
		title: 'Company Identity',
		subtitle: 'People need to know who you are',
		icon: 'mdi-home',
		cards: [
			{
				active: true,
				show: true,
				width: 420,
				title: 'What is your main company phone number?',
				subtitle: 'This will be displayed as your Calling Line Identity Number',
				input: {
					width: 200,
					type: 'phoneNumber',
					key: 'callingLineIdPhoneNumber'
				}
			},
			{
				active: true,
				show: true,
				width: 500,
				title: 'What name do you want to display when making calls?',
				subtitle: 'This will be displayed as your Calling Line Identity Name',
				input: {
					width: 150,
					type: 'text',
					key: 'callingLineIdName'
				}
			},
			{
				active: false,
				show: true,
				width: 380,
				title: 'What is your company website?',
				subtitle: 'Leave blank if you do not have a website',
				input: {
					width: 250,
					type: 'text',
					key: 'domain'
				}
			}
		]
	},
	{
		title: 'Extension Dialing',
		subtitle: 'For when you need to transfer or forward calls',
		icon: 'mdi-dialpad',
		cards: [
			{
				active: false,
				show: true,
				width: 400,
				title: 'How many digits for extension dialing?',
				input: {
					width: 120,
					type: 'select',
					items: ['2 Digits','3 Digits','4 Digits'],
					key: 'extensionDigits'
				}
			},
			{
				active: true,
				show: true,
				width: 450,
				title: 'Automatically assign user extensions?',
				subtitle: 'Recommended for most customers',
				input: {
					type: 'boolean',
					key: 'extensionMatching'
				}
			}
		]
	},
	{
		title: 'User Setup',
		subtitle: 'Let\'s evaluate your user requirements',
		icon: 'mdi-account',
		cards: [
			{
				active: true,
				show: true,
				width: 380,
				title: 'How many users need a desk phone?',
				input: {
					width: 200,
					type: 'select',
					items: ['None','Everyone','Less than 10 users','More than 10 users'],
					key: 'userDeskPhoneCount'
				}
			},
			{
				active: true,
				show: true,
				width: 390,
				title: 'How many users need a phone number?',
				input: {
					width: 200,
					type: 'select',
					items: ['None','Everyone','Less than 10 users','More than 10 users'],
					key: 'userPhoneNumberCount'
				}
			},
			{
				active: true,
				show: true,
				width: 440,
				title: 'How many users will be working from home?',
				input: {
					width: 200,
					type: 'select',
					items: ['None','Everyone','Less than 10 users','More than 10 users'],
					key: 'userWorkFromHomeCount'
				}
			}
		]
	},
	{
		title: 'Main Line',
		subtitle: 'Incoming call handling',
		icon: 'mdi-phone-ring',
		cards: [
			{
				active: true,
				show: true,
				width: 480,
				title: 'Do you want your calls live answered?',
				subtitle: 'Select "No" if you want to use a greeting or menu of options instead',
				input: {
					type: 'boolean',
					key: 'mainLineAutoAttendant'
				}
			},
			{
				active: true,
				show: false,
				width: 530,
				title: 'How many users should ring when your company is called?',
				subtitle: 'You will select the users later on in the setup',
				input: {
					width: 200,
					type: 'select',
					items: ['None','Everyone','Less than 10 users','More than 10 users'],
					key: 'mainLineUserRingCount'
				}
			},
			{
				active: true,
				show: false,
				width: 410,
				title: 'What are the staffed hours of operation?',
				subtitle: 'Leave blank if not applicable',
				input: {
					width: 300,
					type: 'text',
					placeholder: 'Example: Mon-Fri 9AM-5PM',
					key: 'mainLineHours'
				}
			},
			{
				active: false,
				show: false,
				width: 500,
				title: 'Ok, great. We\'ll help you configure an <a href="https://www.tpx.com/support/knowledge-base/introduction-auto-attendant/" target="_blank">Automated Attendant</a> later on in the setup process. ',
				subtitle: '',
				input: {
					key: null
				}
			}
		]
	}
]