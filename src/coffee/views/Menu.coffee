define [
	"./Abstract"
], (AbstractView)->
	
	class MenuView extends AbstractView

		template: _.template $("#menu-template").html()

		initialize:->
			do @render

		render:->
			@$el.html @template()