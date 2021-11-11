module.exports = {
    transpileDependencies: ["vuetify"],
    publicPath: '/',
    devServer: {
    	port: 80,
	},
	pluginOptions: {
	    browserSync: {
	    	port: 3000,
	    	host: 'localhost',
	    	proxy: 'localhost:80',
	    	reload: false
	    }
	}
}