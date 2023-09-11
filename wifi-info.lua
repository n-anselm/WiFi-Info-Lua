-- Created: 230908
-- Modified: 230911
-- Author: n-anselm, ChatGPT

local cmd_exit_status = os.execute("nmcli device wifi show-password > wifi-data.txt")

if cmd_exit_status then
    filename = "wifi-data.txt"
    -- Attempt to open the file in read mode
    local file, file_error_msg = io.open(filename, "r")
    if not file then
    	-- Handle the error if the file could not be opened
    	print("Error opening the file: " .. error_message)
    else
    	-- Read the file contents to a variable
    	local file_contents = file:read("*a") -- Read the entire file
    	-- Close the file
    	file:close()
    	
    	-- Lines to print starting with
    	local keys_to_include = {"SSID", "Password"}
    	
    	-- Initialize an empty table to store the key-value pairs
		local data_table = {}
		-- Parse the input text into the data table
		for line in file_contents:gmatch("[^\n]+") do
			local key, value = line:match("([^:]+):%s*(.+)")
		    if key and value then
		    	-- Check if the key is in the keys_to_include table
		        if table.concat(keys_to_include, ","):find(key) then
            print(key .. ": " .. value)
				end
		    end
		end
    end
    del_file_cmd = ("rm " .. filename)
    -- Delete the file that was used to store data
    local delete_status = os.execute(del_file_cmd)
    if not delete_status then
    	print("Error deleting file")
    end
else
    --failed
    --print("Program failed")
end
