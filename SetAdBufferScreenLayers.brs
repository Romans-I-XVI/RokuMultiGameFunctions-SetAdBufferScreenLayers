function SetAdBufferScreenLayers(game_name as String, hd_splash as String, sd_splash as String, background_color = "#FF040404" as String, text_color = "#FFCCCCCC" as String)
	device_info = CreateObject("roDeviceInfo")
	display_size = device_info.GetDisplaySize()
	aspect_ratio = device_info.GetDisplayAspectRatio()
	if aspect_ratio = "4x3"
		splash_url = sd_splash
	else
		splash_url = hd_splash
	end if

	background_layer = {
		Color: background_color
		TargetRect: {x: 0, y: 0, w: display_size.w, h: display_size.h}
	}
	image_layer = {
		url: splash_url,
		TargetRect: {x: cint(display_size.w / 2 - display_size.w * 0.375 / 2), y: cint(display_size.h * 0.12), w: cint(display_size.w * 0.375), h: cint(display_size.h * 0.375)}
	}
	text_layer = {
		Text: game_name + " will be right back",
		TargetRect: {x: 0, y: image_layer.TargetRect.y + image_layer.TargetRect.h + 10, w: display_size.w, h: 100},
		TextAttrs: {
			Color: text_color,
			Font: "Large",
			HAlign: "HCenter",
			VAlign: "Top "
		}
	}
	screen_elements = [
		image_layer,
		text_layer
	]

	adIface = Roku_Ads()
	adIface.setAdBufferScreenLayer(1, background_layer)
	adIface.setAdBufferScreenLayer(2, screen_elements)
	adIface.enableAdBufferMessaging(false, true)
end function
