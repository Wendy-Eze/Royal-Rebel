extends Node

@onready var index = 0
signal start
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Globalvar.opening_done:
		$BackButton.disabled = false
		$NextButton.disabled = false
	else:
		$BackButton.disabled = true
		$NextButton.disabled = true
		
	if index == 0:
		$BackButton.disabled = true
		$Step1.show()
		$Step2.hide()
		$Step3.hide()
		$Step4.hide()
		$Step5.hide()
		$Step6.hide()
		$Step7.hide()
	
	if index == 1:
		$BackButton.disabled = false
		$Step1.hide()
		$Step2.show()
		$Step3.hide()
		$Step4.hide()
		$Step5.hide()
		$Step6.hide()
		$Step7.hide()
	
	if index == 2:
		$Step1.hide()
		$Step2.hide()
		$Step3.show()
		$Step4.hide()
		$Step5.hide()
		$Step6.hide()
		$Step7.hide()
	
	if index == 3:
		$Step1.hide()
		$Step2.hide()
		$Step3.hide()
		$Step4.show()
		$Step5.hide()
		$Step6.hide()
		$Step7.hide()
	
	if index == 4:
		$Step1.hide()
		$Step2.hide()
		$Step3.hide()
		$Step4.hide()
		$Step5.show()
		$Step6.hide()
		$Step7.hide()
	
	if index == 5:
		$Step1.hide()
		$Step2.hide()
		$Step3.hide()
		$Step4.hide()
		$Step5.hide()
		$Step6.show()
		$Step7.hide()
		
	if index == 6:
		$Step1.hide()
		$Step2.hide()
		$Step3.hide()
		$Step4.hide()
		$Step5.hide()
		$Step6.hide()
		$Step7.show()
	
	if index == 7:
		$Step1.hide()
		$Step2.hide()
		$Step3.hide()
		$Step4.hide()
		$Step5.hide()
		$Step6.hide()
		$Step7.hide()
		start.emit()
	


func _on_back_button_pressed():
	index -= 1


func _on_next_button_pressed():
	index += 1
	#if index == 8:

