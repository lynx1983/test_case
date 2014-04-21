define [
	"./Abstract"
], (AbstractView)->
	
	class MenuView extends AbstractView

		events:
			"click a": "onLinkClick"

		template: _.template $("#menu-template").html()

		initialize:->
			@eventBus.on "anchor.reached", @onAnchorReached, @
			$(window).on "scroll", @reset
			do @render

		render:->
			@$el.html @template()

		onLinkClick:(e)->
			@eventBus.trigger "menu.link", $(e.target).attr("href")
			false

		onAnchorReached:(id)->
			do @reset
			item = @$el.find "[href='##{id}']"
			if item.length 
				item.parent().addClass "active"

		reset:=>
			@$el.find("li").removeClass "active"