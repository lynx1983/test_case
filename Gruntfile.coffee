module.exports = (grunt) ->
	path = require("path")

	grunt.initConfig(

		paths:
			src: "src"
			target: "out"

		less:
			debug:
				files: "<%=paths.target%>/css/common.css": ["<%=paths.src%>/less/common.less"]
			release:
				options:
					yuicompress: true
				files: "<%=paths.target%>/css/common.css": ["<%=paths.src%>/less/common.less"]

		clean:
			files:
				src:["<%=paths.target%>"]
			options:
				force: true

		coffee:
			client:
				expand: true
				cwd: "<%=paths.src%>/coffee/"
				src: ["**/*.coffee"]
				dest: "<%=paths.target%>/js/"
				ext: ".js"

		requirejs:
			cient:
				options:
					name: "main"
					baseUrl: "<%=paths.target%>/js/"
					mainConfigFile: "<%=paths.target%>/js/main.js"
					out: "<%=paths.target%>/js/main.js"

		jade:
			debug:
				options:
					pretty: true
				files:
					"<%=paths.target%>/index.html": "<%=paths.src%>/jade/index.jade"

		watch:
			coffee:
				files: "<%=paths.src%>/coffee/*.coffee"
				tasks: ["coffee"]
			less:
				files: "<%=paths.src%>/less/*.less"
				tasks: ["less"]
			jade: 
				files: "<%=paths.src%>/jade/*.jade"
				tasks: ["jade"]

		copy:
			assets:files: [
				flattern: true
				expand: true
				src: ["**"]
				cwd: "src/assets"
				dest: "<%=paths.target%>"
			]
			libjs:files:[
				expand: true
				flatten: true
				cwd: "bower_components/" 
				src: [
					"requirejs/require.js"
					"backbone/backbone.js"
					"underscore/underscore.js"
					"jquery/jquery.js"
					"requirejs-domready/domReady.js"
				] 
				dest: "<%=paths.target%>/js/lib"
			]

		compress: 
			main:
				options:
					archive: '<%= resource.root %>/<%= gruntconfig.release %>/release.zip'
				files: [
					expand: true
					cwd: '<%= resource.root %>/<%= gruntconfig.release %>/<%= resource.www %>/'
					src: ['**/*']
					dest: 'www/'
				]

		connect:
			dev:
				options:
					hostname: '*'
					port: 9090 
					base: "<%=paths.target%>"

			release:
				options:
					hostname: '*'
					port: 9090
					base: "<%=paths.target%>"
					keepalive: true
	)

	grunt.registerTask('css-build-dev', ['less'])
	grunt.registerTask('css-build', ['css-build-dev'])
	grunt.registerTask('js-build-dev', ['coffee'])
	grunt.registerTask('js-build', ['coffee', 'requirejs'])
	grunt.registerTask('jade-build', ['jade'])
	grunt.registerTask('build-dev', ['css-build-dev', 'js-build-dev', 'jade-build'])
	grunt.registerTask('build', ['css-build', 'js-build', 'jade-build'])

	grunt.registerTask('debug', ['clean', 'copy', 'build-dev'])
	grunt.registerTask('debug-run', ['debug', 'connect:dev', 'watch'])
	
	grunt.registerTask('release', ['clean', 'copy', 'build', 'lineremover'])
	grunt.registerTask('release-run', ['release', 'connect:release'])
	grunt.registerTask('release-package', ['release', 'compress'])

	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-less"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-copy"
	grunt.loadNpmTasks "grunt-contrib-requirejs"
	grunt.loadNpmTasks "grunt-contrib-connect"
	grunt.loadNpmTasks "grunt-contrib-watch"
	grunt.loadNpmTasks "grunt-contrib-compress"
	grunt.loadNpmTasks "grunt-contrib-jade"