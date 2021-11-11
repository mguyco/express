<template>
	<v-main class="primary">
		<!--<Fab />-->

		<v-card 
			color="transparent" 
			flat 
			tile>
			<v-card-title>
				<Toolbar 
					:title="'Express Setup'"
					:height="190" />
			</v-card-title>
			<v-card-text>
				<v-window
					v-model="window"
					show-arrows
					dark>
					
					<v-window-item 
						v-for="(item, w) in windows"
						:key="`window-${w}`">
						<v-timeline light>
							<v-timeline-item 
								:icon="item.icon" 
								color="green"
								large>
								<template v-slot:opposite>
									<v-row>
										<v-col cols="12" align="center">
											<div class="display-2 primary--text text--lighten-5 font-weight-thin">
												{{ item.title }}
											</div>
											<div class="headline mt-4 white--text font-weight-thin" style="opacity:0.5">
												{{ item.subtitle }}
											</div>
										</v-col>
									</v-row>
								</template>
								<template v-for="(card, cardIndex) in item.cards">
									<v-card
										v-if="card.active" 
										v-show="card.show" 
										:key="card.input.key" 
										:width="card.width"
										:class="(cardIndex == 0 ? `px-5` : `mt-5 px-5`)">
										<v-card-text>
											<div class="mt-1">
												<div class="body-1" v-html="card.title" />
												<div class="caption grey--text" v-html="card.subtitle" />
											</div>

											<template v-if="card.input.type == 'text'">
												<v-text-field
													v-model="data[card.input.key]"
													:placeholder="card.input.placeholder"
													:style="`width:${card.input.width}px`" 
													@keydown.native="nextCard(cardIndex)" />
											</template>

											<template v-if="card.input.type == 'boolean'">
												<v-radio-group 
													v-model="data[card.input.key]" 
													@change="nextCard(cardIndex)" 
													row>
													<v-radio :value="1" label="Yes" />
													<v-radio :value="0" label="No" />
												</v-radio-group>
											</template>

											<template v-if="card.input.type == 'select'">
												<v-select
													v-model="data[card.input.key]"
													:items="card.input.items"
													:style="`width:${card.input.width}px`"
													@click="nextCard(cardIndex)" />
											</template>

											<template v-if="card.input.type == 'phoneNumber'">
												<v-combobox
													v-model="data[card.input.key]"
													item-text="TN"
													:items="phoneNumbers"
													:style="`width:${card.input.width}px`"
													@click="nextCard(cardIndex)" />
											</template>

										</v-card-text>
									</v-card>
								</template>
							</v-timeline-item>
						</v-timeline>
					</v-window-item>
				</v-window>
				<v-container>
					<v-row>
						<v-col cols="12" align="center">
							<v-item-group
								class="my-5"
								v-model="window"
								style="opacity:0.77"
								mandatory
								dark>
								<v-item
									v-for="(w, index) in windows"
									v-slot:default="{ active, toggle }" 
									:key="`toggle-item-${index}`">
									<v-btn 
										:input-value="active"
										@click="toggle"
										icon>
										<v-icon>mdi-record</v-icon>
									</v-btn>
								</v-item>
							</v-item-group>
							<v-btn
								class="mt-5"
								color="green"
								@click="window++"
								x-large
								rounded
								dark>Continue
							</v-btn>
						</v-col>
					</v-row>
				</v-container>
			</v-card-text>
		</v-card>
	</v-main>
</template>

<script>
import Toolbar from '@/components/Toolbar'
//import Fab from './../Support/Fab'
import { questions } from './questions'

export default {
	components: {
		Toolbar
		//Fab
	},
	computed: {
		id() {
			return this.$store.getters.id
		},
		order() {
			return this.$store.getters.order
		},
		mainLineAutoAttendant() {
			return this.data.mainLineAutoAttendant
		},
		phoneNumbers() {
			return this.order.phoneNumbers.map(item => {
				return item.TN
			})
		}
	},
	data() {
		return {
			interval: null,
			window: 0,
			windows: questions,
			data: {
				callingLineIdName: '',
				callingLineIdPhoneNumber: '',
				domain: '',
				extensionDigits: '4 Digits',
				extensionMatching: 1,
				userDeskPhoneCount: 'None',
				userPhoneNumberCount: 'None',
				userWorkFromHomeCount: 'None',
				mainLineAutoAttendant: null,
				mainLineUserRingCount: 'Everyone',
				mainLineHours: ''
			}
		}
	},
	mounted() {
		this.initialize()
	},
	methods: {
		newCustomer() {
			this.windows.forEach(item => {
				item.cards.forEach(card => {
					card.active = true
				})
			})
		},
		nextCard(index) {
			const item = this.windows[this.window]

			if((index + 1) > (item.cards.length - 1)) return false

			if(Object.prototype.hasOwnProperty.call(this.data, item.cards[index].input.key)) {
				if(this.data[item.cards[index].input.key].length == 0) return false
			}

			const card = item.cards[index + 1]

			card.show = (card.active == true ? true : false)
		},
		save() {
			const express = this.getJSON(this.id)
			const data = this.$store.getters.data

			this.setState({ 
				data: { 
					...data,
					callingLineId: {
						name: this.data.callingLineIdName,
						phoneNumber: this.data.callingLineIdPhoneNumber
					},
					domain: this.data.domain,
					extensions: {
						...data.extensions,
						auto: this.data.extensionMatching,
						length: this.data.extensionDigits
					}
				}
			})

			this.saveJSON(this.id, {
				...express,
				data: this.$store.getters.data,
				route: this.$route.name,
				window: this.window
			})
		},
		initialize() {
			console.log('Questions initialize')

			const express = this.getJSON(this.id)

			if(Object.prototype.hasOwnProperty.call(express, 'data')) {
				this.data = {
					...this.data,
					callingLineIdName: express.data.callingLineId.name,
					callingLineIdPhoneNumber: express.data.callingLineId.phoneNumber,
					domain: express.data.domain,
					extensionDigits: express.data.extensions.length,
					extensionMatching: express.data.extensions.auto,
				}
			}

			if(Object.prototype.hasOwnProperty.call(express, 'window')) {
				this.window = express.window
			}

			if(this.order.account.enterpriseMappingID == null)  {
				this.newCustomer()
			}

			console.log(this.order)

			this.save()
		}
	},
	watch: {
		order() {
			this.initialize()
			this.save()
		},
		mainLineAutoAttendant() {
			const bool = (this.mainLineAutoAttendant == 1 ? true : false)

			this.windows[3].cards[3].active = !bool
			this.windows[3].cards[3].show = !bool

			this.windows[3].cards[1].show = bool
			this.windows[3].cards[2].show = bool
		},
		window() {
			this.save()

			if(this.data.callingLineIdPhoneNumber != '') {
				this.windows[3].title = this.data.callingLineIdPhoneNumber
				this.windows[3].subtitle = 'Main line incoming call handling'
			}

			else {
				this.windows[3].title = 'Main Line'
				this.windows[3].subtitle = 'Incoming call handling'
			}

			if(this.window == this.windows.length) {
				this.$router.push({
					name: 'Setup'
				})
			}
		}
	}
}
</script>