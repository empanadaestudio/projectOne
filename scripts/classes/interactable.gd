extends Spatial
class_name InteractableClass

export var order := 1

var args := {
	"order": order,
	"state": false
	}

signal active(node, arg)
signal desactive(node, arg)

func _ready():
	args.order = order

func activated(arguments : Dictionary):
	emit_signal("active", self, arguments)

func desactive(arguments : Dictionary):
	emit_signal("desactive", self, arguments)
