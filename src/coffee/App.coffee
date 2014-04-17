define [
	"./views/Abstract"
	"./views/Loader"
	"./views/Main"
], (AbstractView, LoaderView, MainView)->
	
	class App extends AbstractView
		
		el: "#content"
		
		initialize:->
			@loader = new LoaderView
			@main = new MainView
			@eventBus.on "init", @afterLoad, @

		start:->
			@setView @loader

		afterLoad:->
			@setView @main
			
		setView:(view)->
			@$el.fadeOut =>
				@$el.html view.render().$el
				do @$el.fadeIn

	new App