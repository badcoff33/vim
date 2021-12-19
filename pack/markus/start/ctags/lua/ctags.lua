-- Like Lorenso said above, read starts at the current file position and reads from that position some portion of the file. How much of the file it reads depends on read instruction. For reference, in Lua 5.3:
-- 
--     "*all" : reads to the end of the file
--     "*line" : reads from the current position to the end of the line. The end of the line is marked by a special character usually denoted LfCr (Line feed, carriage return )
--     "*number" : reads a number, that is, it will read up to the end of what it recognizes in the text as a number, stopping at, for example, a comma ",".
--     num : reads a string with up to num characters
-- 
-- Here's an example that reads a file with a list of numbers into an array (a table), then returns the array. (Just change the "*number" to "*line" and it would read a file line by line):

-- LUA intros used here
--  https://www.tutorialspoint.com/lua/lua_file_io.htm
-- CAll from Vimscript with :call luaeval('require "ctags"')

function read_array(file)
  local arr = {}
  local handle  = assert( io.open(file,"r") )
  local value = handle:read("*line")
  while value do
    table.insert( arr, value )
    value = handle:read("*number")
  end
  handle:close()
  return arr
end
