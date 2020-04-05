# LuaMinify

Lua minification library.

## Features

* css minification
* html minification (WIP)
* js minification (WIP)
* etlua html template minification (WIP)

## Install

`luarocks install luaminify`

## Usage

Code:
```
local minify=require("minify")
print(minify.css('* { a:b; }'))
```
Result: 
```
"*{a:b}"
```

### OR
Code:
```
local minify_css=require("minify.css")
print(minify_css('* { a:b; }'))
```
Result: 
```
"*{a:b}"
```
