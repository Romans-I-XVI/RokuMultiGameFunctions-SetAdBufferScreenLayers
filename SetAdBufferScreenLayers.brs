function SetAdBufferScreenLayers(image_url as String, background_color = "#FF040404" as String)
	device_info = CreateObject("roDeviceInfo")
	display_size = device_info.GetDisplaySize()
	bitmap = CreateObject("roBitmap", image_url)

	background_layer = {
		Color: background_color
		TargetRect: {x: 0, y: 0, w: display_size.w, h: display_size.h}
	}
	scale = 1.0
	if device_info.GetDisplayAspectRatio() = "4x3"
		scale = 0.75
	end if
	bitmap_scaled_size = {width: cint(bitmap.GetWidth() * scale), height: cint(bitmap.GetHeight() * scale)}
	image_layer = {
		url: image_url,
		TargetRect: {x: cint(display_size.w / 2 - bitmap_scaled_size.width / 2), y: cint(display_size.h * 0.12), w: bitmap_scaled_size.width, h: bitmap_scaled_size.height}
	}

	adIface = Roku_Ads()
	adIface.setAdBufferScreenLayer(1, background_layer)
	adIface.setAdBufferScreenLayer(2, image_layer)
	adIface.enableAdBufferMessaging(false, true)
end function

function DrawAdBufferScreenLayersToScreen(screen as Object, image_url as String, extra_text = "" as String, background_color = &h040404FF as Integer)
	bitmap = CreateObject("roBitmap", image_url)
	scale = invalid
	font_size = 22
	if CreateObject("roDeviceInfo").GetDisplayAspectRatio() = "4x3"
		scale = 0.75
		font_size = 18
	end if

	screen.Clear(background_color)
	if scale = invalid
		screen.DrawObject(cint(screen.GetWidth() / 2 - bitmap.GetWidth() / 2), cint(screen.GetHeight() * 0.12), bitmap)
	else
		screen.DrawScaledObject(cint(screen.GetWidth() / 2 - (bitmap.GetWidth() / 2) * scale), cint(screen.GetHeight() * 0.12), scale, scale, bitmap)
	end if
	if extra_text <> ""
		font_registry = CreateObject("roFontRegistry")
		font = font_registry.GetDefaultFont(font_size, true, false)
		screen.DrawText(extra_text, cint(screen.GetWidth() / 2 - font.GetOneLineWidth(extra_text, 10000) / 2), cint(screen.GetHeight() * 0.833333333), &hCCCCCCFF, font)
	end if
end function
