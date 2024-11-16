local ls = require 'luasnip'

ls.config.set_config {
  history = true,
  updateevents = 'TextChanged, TextChangedI',
  enable_autosnippets = true,
  store_selection_keys = '<Tab>',
}

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

local get_visual = function(args, parent)
  if #parent.snippet.env.LS_SELECT_RAW > 0 then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  -- NOTE: Tutorial https://ejmastnak.com/tutorials/vim(-latex/luasnip/
  require('luasnip').snippet({
    trig = 'hi', --here not only strings are supported but also lua-flavored regex
    dscr = "An autotriggering snippet that expands 'hi' into 'Hello, world!'",
    regTrig = false, --this defines that the trigger is not a regular expression
    priority = 100, --the default priority is 1000
    wordTrig = false,
    snippetType = 'autosnippet', --defines if the snippet is triggered when the trigger is part of a larger word, the default is true
  }, {
    t 'Hello, world!', -- A single text node
  }),

  require('luasnip').snippet({ trig = 'foo' }, { t 'Another snippet.' }),
  s({ trig = 'lines', dscr = 'Demo: a text node with three lines.' }, {
    t { 'Line 1', 'Line 2', 'Line 3' },
  }),

  -- the following example shows how to combine text nodes and insert nodes. But this becomes unreadable quickly
  -- thus the fmta syntax is better for such a case. fmta is analogous to fmt but uses <> instead of {} to denote insertnodes
  -- if you want to use a real < or > just use << and >>, \ can be written with \\
  s({ trig = 'eq1', dscr = 'A LaTeX equation environment' }, {
    t { -- using a table of strings for multiline text
      '\\begin{equation}',
      '    ',
    },
    i(1),
    t {
      '',
      '\\end{equation}',
    },
  }),

  s(
    { trig = 'eq2', dscr = 'A LaTeX equation environment' },
    fmta( -- [[]] defines a multiline string in lua.
      [[
      \begin{equation}
          <>
      \end{equation}
      ]],
      { i(1) },
      {}
    )
  ),

  s(
    { trig = 'env' },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
      <>
    ]], -- i(0) defines the exit point of the snippet, per default this exit point is after the last character of the snippet.
      {
        i(1, 'placeholderName'), -- the second arg in i node defines the placeholder of the insert node
        i(2),
        rep(1), -- this node repeats insert node i(1)
        i(0),
      }
    )
  ),

  -- Mit dem folgenden Snippet kann man einen Text mit v markieren, dann Tab drücken und danach den Triggernamen für das Snippet angeben, um das kopierte
  -- in das Snippet einzufügen. => Könnte nützlich sein für Kommentare.
  s(
    { trig = 'tii', dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta('\\textit{<>}', {
      d(1, get_visual),
    })
  ),
  --NOTE: Bracket snippets:
  s({ trig = '(', snippetType = 'autosnippet', wordTrig = false }, { t '(', i(1), t ')', i(0) }),
  s({ trig = '[', snippetType = 'autosnippet', wordTrig = false }, { t '[', i(1), t ']', i(0) }),
  s({ trig = '"', snippetType = 'autosnippet', wordTrig = false }, { t '"', i(1), t '"', i(0) }),
  s({ trig = "'", snippetType = 'autosnippet', wordTrig = false }, { t "'", i(1), t "'", i(0) }),
  s({ trig = '<', snippetType = 'autosnippet', wordTrig = false }, { t '<', i(1), t '>', i(0) }),
  s({ trig = '{', snippetType = 'autosnippet', wordTrig = false }, { t '{', i(1), t '}', i(0) }),
}
