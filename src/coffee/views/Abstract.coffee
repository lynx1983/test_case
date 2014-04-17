define [
	"backbone"
], (Backbone)->

	EventBus = _.extend({}, Backbone.Events)

	class AbstractView extends Backbone.View
		constructor:->
			@eventBus = EventBus
			super