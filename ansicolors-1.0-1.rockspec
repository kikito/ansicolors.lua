package = "ansicolors"
version = "1.0-1"
source = {
  url = "https://github.com/downloads/kikito/ansicolors.lua/ansicolors-1.0.tar.gz"
}
description = {
  summary = "Library for color Manipulation.",
  detailed = [[
    Ansicolors is a simple Lua function for printing to the console in color.
  ]],
  homepage = "https://github.com/kikito/ansicolors.lua",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1"
}
build = {
  type = "builtin",
  modules = {
    ["ansicolors"] = "ansicolors.lua"
  }
}
