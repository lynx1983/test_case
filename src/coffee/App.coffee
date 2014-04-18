define [
	"./views/Abstract"
	"./views/Loader"
	"./views/Main"
	"./views/Page"
], (AbstractView, LoaderView, MainView, PageView)->
	
	class App extends AbstractView
		
		el: "body"
		
		initialize:->
			@loader = new LoaderView
				resources: [
					type: "image"
					src: "/img/main_bg.png"
				,
					type: "image"
					src: "/img/clouds_1.png"
				,
					type: "image"
					src: "/img/clouds_2.png"
				]

			@main = new MainView
				pages: [
					new PageView
						attributes:
							id: "first"
					new PageView
						attributes:
							id: "second"
					new PageView
						attributes:
							id: "third"
					new PageView
						attributes:
							id: "fourth"
				]
			@eventBus.on "loader.complete", @afterLoad, @

		start:->
			@setView @loader

		afterLoad:->
			@setView @main
			
		setView:(view)->
			@$el.fadeOut =>
				@$el.html view.render().$el
				do view.onShow
				do @$el.fadeIn

	new App