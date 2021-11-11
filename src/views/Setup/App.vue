<template>
	<div>
		<Appbar />

		<!-- <Fab /> -->

        <v-main class="mt-5">
			<v-container>
				<v-row no-gutters>
					<v-col cols="12">
						<v-stepper 
							v-model="step" 
							class="elevation-0 transparent">
							<v-stepper-header class="elevation-0">
								<template v-for="(item, index) in steps">
									<v-stepper-step 
										:key="`stepper-${item.step}`"
										:step="item.step"
										:editable="$store.state.valid">
										{{ item.title }}
									</v-stepper-step>
									<v-divider 
										:key="`divider-${item.step}`"
										v-if="index < (steps.length - 1)"
										class="mx-2" />
								</template>
							</v-stepper-header>

							<v-stepper-content step="1">
								<Account @update="update($event)" />
							</v-stepper-content>

							<v-stepper-content step="2">
								<Users @update="update($event)" />
							</v-stepper-content>

							<v-stepper-content step="3">
								<RingGroups @update="update($event)" />
							</v-stepper-content>

							<v-stepper-content step="4">
								<Complete />
							</v-stepper-content>
						</v-stepper>
					</v-col>
				</v-row>
				<v-row class="mb-5 mt-3">
					<v-col cols="12" align="center">
						<v-btn 
							:disabled="!valid"
							v-if="step < steps.length" 
							class="green white--text"
							@click="step++"
							large
							rounded>Continue
						</v-btn>
					</v-col>
				</v-row>
			</v-container>
		</v-main>
	</div>
</template>

<script>
import Appbar from '@/components/Appbar'
//import Fab from './../Support/Fab'
import Account from './Account/App'
import Users from './Users/App'
import RingGroups from './RingGroups/App'
import Complete from './Complete/App'

export default {
	components: {
		Appbar,
		//Fab,
		Account,
		Users,
		RingGroups,
		Complete
	},
	data() {
		return {
			step: 1,
			steps:  [
				{
					title: 'Account Settings',
					step: 1
				},
				{
					title: 'Setup Users',
					step: 2
				},
				{
					title: 'Ring Groups',
					step: 3
				},
				{
					title: 'Complete',
					step: 4
				}
			]
		}
	},
	computed: {
		valid() {
			return this.$store.getters.valid
		},
		id() {
			return this.$store.getters.id
		},
		order() {
			return this.$store.getters.order
		},
		account() {
			return this.$store.getters.account
		},
		data() {
			return this.$store.getters.data
		}
	},
	mounted() {
		this.initialize()
	},
	methods: {
		initialize() {
			//if(!Object.prototype.hasOwnProperty.call(this.account, 'orderID')) return false

			console.log('Setup initialize')

			const express = this.getJSON(this.id)

			if(Object.prototype.hasOwnProperty.call(express, 'window')) {
				this.window = express.window
			}

			if(Object.prototype.hasOwnProperty.call(express, 'step')) {
				this.step = express.step
			}

			if(Object.prototype.hasOwnProperty.call(express, 'data')) {
				this.setData({
					...this.data,
					...express.data
				})
			}
		},
		update(data) {
			this.setData({
				...this.data,
				...data
			})

			this.save()
		},
		save() {
			const express = this.getJSON(this.id)

			this.saveJSON(this.id, {
				...express,
				data: this.data,
				route: this.$route.name,
				step: this.step
			})
		}
	},
	watch: {
		step() {
			if(this.step > this.steps.length) {
				return false
			}

			this.save()
		},
		account() {
			this.initialize()
		}
	}
}
</script>