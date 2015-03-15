function run(msg, matches)

	print ("processing sticker " .. matches[1])

	local response = ""
	local rootpath = _config.repssticker.sticker_path

	local sticker_pairs = {
		["yourhighness"]="briankinghighness",
		["broom"]="eliobroom",
		["plane"]="elioplane",
		["oneminute"]="rosanaoneminute",
		["seriously"]="yofieseriously",
		["what"]="yofiewhat",
		["mbaker"]="mitchellbaker",
		["mypeopleneedme"]="mozillaman",
		["kumi"]="kumi"
	}

	print (" matched: " .. sticker_pairs[ matches[1] ])

	  for k, v in pairs(sticker_pairs) do
	    print("checking sticker", k)

	    if k == matches[1] then

			if messageToAllowed(msg.to.id) == false then

				return ""

			end


			local receiver = get_personal_receiver(msg)
			local file_path = rootpath .. sticker_pairs[ matches[1] ] .. ".webp"
			print(file_path)
			if file_exists(file_path) == true then


				response = matches[1]

				local cb_extra = {
					file_path = file_path,
					cb_function = cb_function,
					cb_extra = cb_extra
				}
				-- Call to remove with optional callback
				-- send_photo(receiver, file_path, rmtmp_cb, cb_extra)

				send_document(receiver, file_path, ok_cb, cb_extra)
				-- send_photo_from_url(receiver, "http://127.0.0.1/stickers/reps/" .. sticker_pairs[ matches[1] ] .. ".webp")
			else
				response = "sticker is missing..."
			end
			break

	    end
	    
	  end


    -- return response
end

function messageToAllowed(id)
	local response = true

	return response
end

function get_personal_receiver(msg)
  if msg.to.type == 'user' then
    return 'user#id'..msg.to.id
  end
  if msg.to.type == 'chat' then
    return 'chat#id'..msg.to.id
  end
end

return {
    description = "load custom stickers", 
    usage = "/sticker [sticker-name]",
    patterns = {
    		"^/sticker (.*)$"
    	}, 
    run = run 
}