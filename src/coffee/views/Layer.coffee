define [
	"backbone"
], (Backbone)->

	class LayerView extends Backbone.View

		initialize:(@options = {})->
			@initial = parseInt(@$el.css("top")) or 0
			@scaling = @options.scaling ? 0.15
			do @move
			$(window).on "scroll", @move

		move:=>
			offset = @initial + @scaling * $(window).scrollTop()
			@$el.css "top", "#{offset}px"