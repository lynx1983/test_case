requirejs.config
	baseUrl: "/js"
	paths: 
		underscore: "lib/underscore"
		backbone: "lib/backbone"
		jquery: "lib/jquery"
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

require [
	"underscore"
	"domReady"
	"App"
], (_, domReady, App)->
	"use strict"

	domReady ->
		do App.start