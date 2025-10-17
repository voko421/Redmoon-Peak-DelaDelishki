/datum/stressevent/goodloving
	timer = 5 MINUTES
	stressadd = -3
	desc = "<span class='green'>Совсем недавно мне было очень хорошо!</span>"

/datum/status_effect/buff/goodloving
	id = "Good Loving"
	alert_type = /atom/movable/screen/alert/status_effect/buff/goodloving
	effectedstats = list("fortune" = 2)
	duration = 60 MINUTES

/atom/movable/screen/alert/status_effect/buff/goodloving
	name = "Good Loving"
	desc = "Совсем недавно мне было очень хорошо из-за самой настоящей Эоровой Любви."
	icon_state = "stressg"
