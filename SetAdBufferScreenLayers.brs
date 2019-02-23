function SetAdBufferScreenLayers(game_name as String, hd_image as String, sd_image as String, background_color = "#FF040404" as String, text_color = "#FFCCCCCC" as String)
	device_info = CreateObject("roDeviceInfo")
	display_size = device_info.GetDisplaySize()
	aspect_ratio = device_info.GetDisplayAspectRatio()
	if aspect_ratio = "4x3"
		image_url = sd_image
	else
		image_url = hd_image
	end if
	bitmap = CreateObject("roBitmap", image_url)

	background_layer = {
		Color: background_color
		TargetRect: {x: 0, y: 0, w: display_size.w, h: display_size.h}
	}
	image_layer = {
		url: image_url,
		TargetTranslation: {x: cint(display_size.w / 2 - bitmap.GetWidth() / 2), y: cint(display_size.h * 0.12)}
	}
	text_layer = {
		Text: game_name + " will be right back",
		TargetRect: {x: 0, y: image_layer.TargetTranslation.y + bitmap.GetHeight() + 10, w: display_size.w, h: 100},
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
