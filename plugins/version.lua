do

function run(msg, matches)
  return 'ARASH '.. VERSION .. [[ 
  ARASH @arash_admin_death
  GNU GPL v2 license.]]
end

return {
  description = "Shows bot version", 
  usage = "!version: Shows bot version",
  patterns = {
    "^!version$"
  }, 
  run = run 
}

end
