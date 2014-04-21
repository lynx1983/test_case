requirejs.config
	baseUrl: "/js"
	paths: 
		underscore: "lib/underscore"
		backbone: "lib/backbone"
		jquery: "lib/jquery"
		jqueryeasing: "lib/jquery.easing"
		domReady: "lib/domReady"
	shim:
		jquery: 
			exports: "jQuery"
		backbone:
			deps: ["underscore", "jquery"]
			exports: "Backbone"
		underscore:
			exports: "_"
		domReady:
			exports: "domReady"
		jqueryeasing:
			deps: ["jquery"]

require [
	"underscore"
	"domReady"
	"App"
], (_, domReady, App)->
	"use strict"

	domReady ->
		do App.start