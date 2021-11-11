<template>
	<div>
		<v-bottom-sheet v-model="open">
			<v-sheet height="200px">
				
			</v-sheet>
		</v-bottom-sheet>
		<v-tooltip color="pink" left>
			<template v-slot:activator="{ on }">
				<v-btn 
					class="mx-2" 
					color="pink"
					v-on="on" 
					@click="open = !open"
					bottom 
					fixed 
					fab
					right 
					dark>
					<v-icon large dark>mdi-face-agent</v-icon>
				</v-btn>
			</template>
			<span>Click here for support</span>
		</v-tooltip>
	</div>
</template>

<script>
export default {
	props: {
		order: Object
	},
	data() {
		return {
			open: false
		}
	}
}
</script>