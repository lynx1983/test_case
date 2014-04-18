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
					compress: true
				files: "<%=paths.target%>/css/common.css": ["<%=paths.src%>/less/common.less"]

		clean:
			files:
				src:["<%=paths.target%>"]
			temp:
				src:["<%=paths.target%>/_js"]
			options:
				force: true

		coffee:
			debug:
				expand: true
				cwd: "<%=paths.src%>/coffee/"
				src: ["**/*.coffee"]
				dest: "<%=paths.target%>/js/"
				ext: ".js"
			release:
				expand: true
				cwd: "<%=paths.src%>/coffee/"
				src: ["**/*.coffee"]
				dest: "<%=paths.target%>/_js/"
				ext: ".js"

		requirejs:
			cient:
				options:
					name: "main"
					baseUrl: "<%=paths.target%>/_js/"
					mainConfigFile: "<%=paths.target%>/_js/main.js"
					out: "<%=paths.target%>/js/main.js"

		jade:
			debug:
				options:
					pretty: true
				files:
					"<%=paths.target%>/index.html": "<%=paths.src%>/jade/index.jade"

		watch:
			coffee:
				files: ["**/*.coffee"]
				tasks: ["coffee"]
				options: 
					cwd: "<%=paths.src%>/coffee"
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
			libjsdev:files:[
				expand: true
				flatten: true
				cwd: "bower_components/" 
				src: [
					"requirejs/require.js"
					"backbone/backbone.js"
					"underscore/underscore.js"
					"jquery/dist/jquery.js"
					"requirejs-domready/domReady.js"
				]
				dest: "<%=paths.target%>/js/lib"
			]
			libjsrelease:files:[
				expand: true
				flatten: true
				cwd: "bower_components/" 
				src: [
					"requirejs/require.js"
					"backbone/backbone.js"
					"underscore/underscore.js"
					"jquery/dist/jquery.js"
					"requirejs-domready/domReady.js"
				] 
				dest: "<%=paths.target%>/_js/lib"
			]
			requirejsrelease:files:[
				expand: true
				flatten: true
				cwd: "bower_components/" 
				src: [
					"requirejs/require.js"
				] 
				dest: "<%=paths.target%>/js/lib"
			]

		compress: 
			main:
				options:
					archive: '<%=paths.target%>/release.zip'
				files: [
					expand: true
					cwd: '<%=paths.target%>'
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

	grunt.registerTask('css-build-dev', ['less:debug'])
	grunt.registerTask('css-build', ['less:release'])
	grunt.registerTask('js-build-dev', ['coffee:debug'])
	grunt.registerTask('js-build', ['coffee:release', 'requirejs'])
	grunt.registerTask('jade-build', ['jade'])
	grunt.registerTask('build-dev', ['css-build-dev', 'js-build-dev', 'jade-build'])
	grunt.registerTask('build', ['css-build', 'js-build', 'jade-build'])

	grunt.registerTask('debug', ['clean', 'copy:assets', 'copy:libjsdev', 'build-dev'])
	grunt.registerTask('debug-run', ['debug', 'connect:dev', 'watch'])
	
	grunt.registerTask('release', ['clean', 'copy:assets', 'copy:libjsrelease', 'copy:requirejsrelease', 'build', 'clean:temp'])
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