local ls = require("luasnip")
local map = require('config.mapper').map

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node
local d = ls.dynamic_node

ls.filetype_set("c", { "cpp" })

ls.add_snippets(nil, {
  cpp = {
    -- function
    s( { trig = "fn", namer = "Function" }, {
      i(1, "return_type"), t({" "}), i(2, "function_name"), t({"("}), i(3, "params"),
      t({")", "{", "    "}), i(0, ""),
      t({"", "}"})
    }),

    -- class/struct
    s({ trig = "struct", namr = "Struct" }, {
      t({"struct "}), i(1, "struct_name"),
      t({"", "{", "    "}), i(0, ""),
      t({"", "};"})
    }),
    s({ trig = "class", namr = "Class" }, {
      t({"class "}), i(1, "class_name"),
      t({"", "{", "    "}), i(0, ""),
      t({"", "};"})
    }),

    -- fmt
    s( { trig = "println", namr = "Function" }, {
      t({"fmt::println(\""}), i(1, ""), t({"\", "}), i(2, ""), t({");"})
    }),
    s( { trig = "print", namr = "Function" }, {
      t({"fmt::print(\""}), i(1, ""), t({"\", "}), i(2, ""), t({");"})
    }),
    s( { trig = "format", namr = "Function" }, {
      t({"std::format(\""}), i(1, ""), t({"\", "}), i(2, ""), t({");"})
    }),

    -- gtest macro template
    s({ trig = "tt", namr = "TEST" }, {
      t({"TEST("}), i(1, "Fixture"), t({", "}), i(2, "TestName"),
      t({")", "{", "    "}), i(0, ""), t({"", "}"})
    }),
    s({ trig = "ttf", namr = "TEST_F" }, {
      t({"TEST_F("}), i(1, "Fixture"), t({", "}), i(2, "TestName"),
      t({")", "{", "    "}), i(0, ""), t({"", "}"})
    }),
  },
})

map({"i", "s"}, "<c-j>", function() ls.jump(1) end, {silent = true})
map({"i", "s"}, "<c-k>", function() ls.jump(-1) end, {silent = true})
map('n', "<leader>as", "<cmd>so ~/.config/nvim/lua/config/ls.lua | echo 'lua snippet sourced'<cr>")
