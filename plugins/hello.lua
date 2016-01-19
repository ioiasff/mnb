do

function run(msg, matches)
  return "Hello, " .. matches[1]
end

return {
  description = "Says Hello to Someone", 
  usage = "Say Hello to (name)",
  patterns = {
    "^سلام کن به (.*)$",
    "^Say hello to (.*)$"
  }, 
  run = run 
}

end
