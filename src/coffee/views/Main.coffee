define [
	"./Abstract"
	"./Menu"
	"./Layer"
	"jqueryeasing"
], (AbstractView, MenuView, LayerView)->
	class MainView extends AbstractView

		tagName: "main"
		
		template: _.template $("#main-template").html()

		initialize:(@options = {})->
			@moving = no
			@anchors = []
			@

		render:=>
			@$el.html @template()
			@

		setHandlers:=>
			@eventBus.on "menu.link", @onMenuLink
			$(window).on "scroll", _.debounce @moveToClosestAnchor, 1000
			$(window).on "mousedown DOMMouseScroll mousewheel keyup", @stopScroll

		onShow:->
			@$pages = @$el.find ".pages"
			@$clouds_1 = @$el.find ".clouds_1"
			@$clouds_2 = @$el.find ".clouds_1"
			
			for page in @options.pages
				@$pages.append page.render().$el
				@anchors.push page.$el

			@anchors.push @$el.find "#header"

			new MenuView
				el: @$el.find ".main-menu"

			new LayerView
				el: @$el.find ".clouds_1"
				scaling: .5

			new LayerView
				el: @$el.find ".clouds_2"
				scaling: .17

			do @setHandlers

		stopScroll:=>
			$("html, body").stop(true, false) if @moving

		onMenuLink:(target)=>
			anchor = _.find @anchors, (anchor)->
				anchor.is target
			if anchor
				@moveToAnchor anchor
			else
				do @moveToTop

		getClosestAnchor:->
			windowScrollTop = $(window).scrollTop()
			_.min @anchors, (anchor)->
				Math.abs anchor.offset().top - windowScrollTop

		moveToClosestAnchor:=>
			@moveToAnchor do @getClosestAnchor

		scrollTo:(position, callback)->
			@moving = yes
			$("html, body").stop(true, false).animate 
				scrollTop: "#{position}px"
			,
				duration: 2800
				easing: "easeInOutExpo"
				complete:=>
					callback?()
					@moving = no

		moveToTop:->
			@scrollTo 0

		moveToAnchor:(anchor)->
			if anchor 
				@scrollTo anchor.offset().top, =>
					@eventBus.trigger "anchor.reached", anchor.attr("id")