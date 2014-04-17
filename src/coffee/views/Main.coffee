define [
	"./Abstract"
	"./Menu"
], (AbstractView, MenuView)->
	class MainView extends AbstractView

		tagName: "main"
		
		template: _.template $("#main-template").html()

		initialize:->
			setTimeout =>
				@eventBus.trigger "init"
			, 500

		render:=>
			@$el.html @template()

			new MenuView
				el: @$el.find ".main-menu"

			@