extends CanvasLayer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var main_menu = $MainMenu
# onready var login_view = $LoginView
onready var player_score_tag = $PlayerScoreBalance
onready var version_tag = $VersionTag
onready var shop = $Shop
onready var gui = $GUI
onready var shop_button = $ShopButton
onready var sound_button = $SoundButton
# onready var highscores = $Highscores
onready var credits = $Credits

var credits_shown = false

signal buy_item(item_name)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()
	$GUI.hide()
	$Shop.hide()



func _on_SoundButton_sound_off():
	$Music.stop()


func _on_SoundButton_sound_on():
	$Music.play()


func _on_ShopButton_open_shop():
	shop_button.hide()
	$GUI.hide()
	$MainMenu.hide()
	$Shop.show()


func setup_gui():
	if not OS.is_userfs_persistent():
		main_menu.popup.dialog_text = "Do you want to enable cookies to save your game?"
		main_menu.popup.popup_centered_minsize()
		
	for i in Items.items:
		shop.update_shop_stock(i["name"], PlayerInventory.inventory[i["name"] + "Stock"])
		shop.update_shop_price(i["name"], i["price"])
		
	update_score_tag(PlayerInventory.score_balance)

func update_score(score):
	gui.update_score(score)

func update_score_tag(score):
	player_score_tag.update_score(score)
	
func start_game():
	version_tag.hide()
	gui.show_ingame_hud()
	shop_button.hide()
	player_score_tag.hide()
	gui.show_message("Get Ready")
	
func show_game_over():
	gui.show_game_over()
	version_tag.show()
	player_score_tag.show()
	shop_button.show()
	gui.my_highscore.text = "your Highscore: " + str(PlayerInventory.highscore)
	
func show_message(message):
	gui.show_message(message)


# func get_username():
# 	return login_view.get_username()
	
# func get_password():
# 	return login_view.get_password()


func go_to_main_menu():
	gui.hide()
	shop.hide()
	# highscores.hide()
	main_menu.show()
	shop_button.show()


func buy_item(item_name):
	emit_signal("buy_item", item_name)


# func show_highscores():
# 	shop_button.hide()
# 	main_menu.hide()
# 	emit_signal("refresh_highscores")
# 	highscores.show()

func show_credits():
	if credits_shown:
		credits.hide()
		credits_shown = false
	else:
		credits.show()
		credits_shown = true


# func _on_MainMenu_change_user():
# 	login_view.show()
# 	shop_button.hide()
# 	main_menu.hide()
# 	player_score_tag.hide()
