define [
	"./Abstract"
], (AbstractView)->
	class PageView extends AbstractView

		className: "page"

		template: _.template $("#page-template").html()

		initialize:->
			do @render

		render:->
			@$el.html @template()
			@