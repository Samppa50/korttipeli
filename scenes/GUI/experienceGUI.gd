extends Control

var local_xp = 0
var local_level = 0
var local_xp_needed = 0


func _process(delta):
	local_xp = $"/root/experience".xp
	local_level = $"/root/experience".characterlevel
	local_xp_needed = $"/root/experience".xp_required
	$xp.text = str(local_xp)
	$xpNeeded.text = str(local_xp_needed)
	$level.text = str(local_level)
