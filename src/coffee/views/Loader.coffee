define [
	"./Abstract"
], (AbstractView)->
	
	class Loader extends AbstractView

		template: _.template $("#loader-template").html()

		initialize:->

		render:->
			@$el.html @template()
			@