do

local function pairsByKeys (t, f)

      local a = {}

      for n in pairs(t) do table.insert(a, n) end

      table.sort(a, f)

      local i = 0 -- iterator variable

      local iter = function () -- iterator function

        i = i + 1

        if a[i] == nil then return nil

        else return a[i], t[a[i]]

        end

      end

      return iter

    end


local function chat_list(msg)

    local data = load_data(_config.moderation.data)

        local groups = 'groups'

        if not data[tostring(groups)] then

                return 'No groups at the moment'

        end

        local message = 'List of Groups:\n*Use /join (ID) to join*\n\n '

        for k,v in pairs(data[tostring(groups)]) do

                local settings = data[tostring(v)]['settings']

                for m,n in pairsByKeys(settings) do

                        if m == 'set_name' then

                                name = n

                        end

                end


                message = message .. '👥 '.. name .. ' (ID: ' .. v .. ')\n\n '

        end

        local file = io.open("./groups/lists/listed_groups.txt", "w")

        file:write(message)

        file:flush()

        file:close()

        return message

end


local function run(msg, matches)

  if msg.to.type ~= 'chat' or is_sudo(msg) or is_admin(msg) and is_realm(msg) then

  local data = load_data(_config.moderation.data)

    if matches[1] == 'join' and data[tostring(matches[2])] then

        if is_banned(msg.from.id, matches[2]) then

  return 'You are banned.'

  end

      if is_gbanned(msg.from.id) then

            return 'You are globally banned.'

      end

      if data[tostring(matches[2])]['settings']['lock_member'] == 'yes' and not is_owner2(msg.from.id, matches[2]) then

        return 'Group is private.'

      end

          local chat_id = "chat#id"..matches[2]

          local user_id = "user#id"..msg.from.id

     chat_add_user(chat_id, user_id, ok_cb, false) 

  local group_name = data[tostring(matches[2])]['settings']['set_name'] 

  return "Added you to chat:\n\n👥"..group_name.." (ID:"..matches[2]..")"

        elseif matches[1] == 'join' and not data[tostring(matches[2])] then


          return "Chat not found."

        end

     if matches[1] == 'chats'then

       if is_admin(msg) and msg.to.type == 'chat' then

         return chat_list(msg)

       elseif msg.to.type ~= 'chat' then

         return chat_list(msg)

       end 

     end

     if matches[1] == 'chatlist'then

       if is_admin(msg) and msg.to.type == 'chat' then

         send_document("chat#id"..msg.from.id, "./groups/lists/listed_groups.txt", ok_cb, false)

       elseif msg.to.type ~= 'chat' then

         send_document("user#id"..msg.from.id, "./groups/lists/listed_groups.txt", ok_cb, false) 

       end 

     end

end

end


return {

    patterns = {

      "^[/!](chats)$",

      "^[/!](chatlist)$",

      "^[/!](join) (.*)$",

      "^[/!](kickme) (.*)$",

      "^!!tgservice (chat_add_user)$"

    },

    run = run,

}

end
