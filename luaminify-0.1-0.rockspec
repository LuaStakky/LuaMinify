package = "LuaMinify"
version = "0.1-0"
source = {
   url = ""
   tag = "v1.0",
}
description = {
   summary = "An example for the LuaRocks tutorial.",
   detailed = [[
      This is an example for the LuaRocks tutorial.
      Here we would put a detailed, typically
      paragraph-long description.
   ]],
   homepage = "https://",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.4"
}
build={
   type="builtin",
   minify="src/minify/init.lua",
   ["minify.css"]="src/minify/css.lua
}