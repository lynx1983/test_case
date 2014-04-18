define [
	"./Abstract"
], (AbstractView)->
	
	class Loader extends AbstractView

		attributes:
			class: "loader"

		template: _.template $("#loader-template").html()

		initialize:(@options = {})->
			@loaded = 0
			@resources = []

		render:->
			@$el.html @template()
			@

		onShow:->
			if @options.resources?.length
				for resource in @options.resources
					switch resource.type
						when "image"
							image = new Image
							image.src = resource.src
							image.onload = @onLoad
							@resources.push image
			else
				@eventBus.trigger "loader.complete"

		onLoad:=>
			@loaded++
			do @update
			if @loaded is @options.resources.length
				@eventBus.trigger "loader.complete"

		update:->
			value = @loaded / @options.resources.length * 100
			@$el.find(".progress").css "width", "#{value}%"