define [
	"./Abstract"
], (AbstractView)->
	
	class MenuView extends AbstractView

		events:
			"click a": "onLinkClick"

		template: _.template $("#menu-template").html()

		initialize:->
			do @render

		render:->
			@$el.html @template()

		onLinkClick:(e)->
			@eventBus.trigger "menu.link", $(e.target).attr("href")
			false