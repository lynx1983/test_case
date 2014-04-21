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
			@

		render:=>
			@$el.html @template()
			@

		setHandlers:=>
			@eventBus.on "menu.link", @onMenuLink
			$(window).on "scroll", _.debounce @moveToClosestPage, 1000
			$(window).on "mousedown DOMMouseScroll mousewheel keyup", @stopScroll

		onShow:->
			@$pages = @$el.find ".pages"
			@$clouds_1 = @$el.find ".clouds_1"
			@$clouds_2 = @$el.find ".clouds_1"
			
			for page in @options.pages
				@$pages.append page.render().$el

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
			page = _.find @options.pages, (page)->
				page.$el.is target
			if page
				@moveToPage page
			else
				do @moveToTop

		getClosestPage:->
			windowScrollTop = $(window).scrollTop()
			_.min @options.pages, (page)->
				Math.abs page.$el.offset().top - windowScrollTop

		moveToClosestPage:=>
			if $(window).scrollTop() > 0
				@moveToPage do @getClosestPage

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

		moveToPage:(page)->
			if page 
				@scrollTo page.$el.offset().top