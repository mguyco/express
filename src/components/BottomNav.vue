<template>
	<v-bottom-navigation 
		color="primary"
		background-color="grey lighten-3"
		app 
		grow>
		<v-btn>
			<span>Service Packages</span>
			<v-badge
				content="6">
				<v-icon>mdi-star</v-icon>
			</v-badge>
		</v-btn>

		<v-btn>
			<span>Phone Numbers</span>
			<v-badge
				content="3">
				<v-icon>mdi-phone</v-icon>
			</v-badge>
		</v-btn>

		<v-btn>
			<span>Desk Phones</span>
			<v-badge
				content="2">
				<v-icon>mdi-phone-classic</v-icon>
			</v-badge>
		</v-btn>
	</v-bottom-navigation>
</template>