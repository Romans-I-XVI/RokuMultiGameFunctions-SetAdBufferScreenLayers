function SetAdBufferScreenLayers(image_url as String, background_color = "#FF040404" as String)
	device_info = CreateObject("roDeviceInfo")
	display_size = device_info.GetDisplaySize()
	bitmap = CreateObject("roBitmap", image_url)

	background_layer = {
		Color: background_color
		TargetRect: {x: 0, y: 0, w: display_size.w, h: display_size.h}
	}
	image_layer = {
		url: image_url,
		TargetTranslation: {x: cint(display_size.w / 2 - bitmap.GetWidth() / 2), y: cint(display_size.h * 0.12)}
	}

	adIface = Roku_Ads()
	adIface.setAdBufferScreenLayer(1, background_layer)
	adIface.setAdBufferScreenLayer(2, image_layer)
	adIface.enableAdBufferMessaging(false, true)
end function

function DrawAdBufferScreenLayersToScreen(draw2d as Object, image_url as String, extra_text = "" as String, background_color = &h040404FF as Integer)
	device_info = CreateObject("roDeviceInfo")
	display_size = device_info.GetDisplaySize()
	bitmap = CreateObject("roBitmap", image_url)
	image_pos = {x: cint(display_size.w / 2 - bitmap.GetWidth() / 2), y: cint(display_size.h * 0.12)}

	draw2d.DrawRect(0, 0, draw2d.GetWidth(), draw2d.GetHeight(), background_color)
	draw2d.DrawObject(image_pos.x, image_pos.y, bitmap)
	if extra_text <> ""
		font_registry = CreateObject("roFontRegistry")
		font = font_registry.GetDefaultFont(22, true, false)
		draw2d.DrawText(extra_text, display_size.w / 2 - font.GetOneLineWidth(extra_text, 10000)/2, display_size.h - 120, &hCCCCCCFF, font)
	end if
end function
