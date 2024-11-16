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
  s(
    { trig = '§', snippetType = 'autosnippet', wordTrig = false },
    fmta( -- [[]] defines a multiline string in lua.
      [[
      {
          <>
      }
      ]],
      { i(1) },
      {}
    )
  ),
  s({ trig = '?' }, {
    i(1, 'condition'),
    t ' ? ',
    i(2),
    t ' : ',
    i(3),
  }),
  s(
    { trig = 'pc', dscr = 'public class' },
    fmta(
      [[
      public class <> 
      {
          <>
      }   
      ]],
      { i(1, 'name'), i(2, 'content') },
      {}
    )
  ),
  s(
    { trig = 'ic', dscr = 'internal class' },
    fmta(
      [[
      internal class <> 
      {
          <>
      }   
      ]],
      { i(1, 'name'), i(2, 'content') },
      {}
    )
  ),
  s(
    { trig = 'pcn', dscr = 'public class with namespace' },
    fmta(
      [[
      namespace <> 
      { 
          public class <> 
          {
              <>
          }
      }
      ]],
      { i(1, 'namespaceName'), i(2, 'className'), i(3, 'content') },
      {}
    )
  ),
  s(
    { trig = 'icn', dscr = 'internal class with namespace' },
    fmta(
      [[
      namespace <> 
      { 
          internal class <> 
          {
              <>
          }
      }
      ]],
      { i(1, 'namespaceName'), i(2, 'className'), i(3, 'content') },
      {}
    )
  ),
  s(
    { trig = 'pm', dscr = 'public method' },
    fmta(
      [[
      public <> <>(<>)
      {
          <>
      }
      ]],
      { i(1, 'type'), i(2, 'name'), i(3, 'arguments'), i(4, 'body') },
      {}
    )
  ),
  s(
    { trig = 'prm', dscr = 'protected method' },
    fmta(
      [[
      protected <> <>(<>)
      {
          <>
      }
      ]],
      { i(1, 'type'), i(2, 'name'), i(3, 'arguments'), i(4, 'body') },
      {}
    )
  ),
  s(
    { trig = 'm', dscr = 'private method' },
    fmta(
      [[
      private <> <>(<>)
      {
          <>
      }
      ]],
      { i(1, 'type'), i(2, 'name'), i(3, 'arguments'), i(4, 'body') },
      {}
    )
  ),
  s(
    { trig = 'apm', dscr = 'async public method' },
    fmta(
      [[
      public async Task<<<>>> <>Async(<>, CancellationToken cancellationToken)
      {
          <>
      }
      ]],
      { i(1, 'type'), i(2, 'name'), i(3, 'arguments'), i(4, 'body') },
      {}
    )
  ),
  s(
    { trig = 'aprm', dscr = 'async protected method' },
    fmta(
      [[
      protected async Task<<<>>> <>Async(<>, CancellationToken cancellationToken)
      {
          <>
      }
      ]],
      { i(1, 'type'), i(2, 'name'), i(3, 'arguments'), i(4, 'body') },
      {}
    )
  ),
  s(
    { trig = 'am', dscr = 'async private method' },
    fmta(
      [[
      private async Task<<<>>> <>Async(<>, CancellationToken cancellationToken)
      {
          <>
      }
      ]],
      { i(1, 'type'), i(2, 'name'), i(3, 'arguments'), i(4, 'body') },
      {}
    )
  ),
  s(
    { trig = 'for', dscr = 'foreach' },
    fmta(
      [[
      foreach(var <> in <>)
      {
          <>
      }
      ]],
      { i(2, 'item'), i(1, 'list'), i(3, 'body') },
      {}
    )
  ),
  s(
    { trig = 'if', dscr = 'single if expression' },
    fmta(
      [[
      if(<>)
      {
          <>
      }  
      ]],
      { i(1, 'condition'), i(2, 'body') },
      {}
    )
  ),
  s(
    { trig = 'ie', dscr = 'if else block' },
    fmta(
      [[
      if(<>)
      {
          <>
      }  
      else
      {
          <>
      }
      ]],
      { i(1, 'condition'), i(2, 'body'), i(3, 'body') },
      {}
    )
  ),
  s(
    { trig = 'iie', dscr = 'if if else and else block' },
    fmta(
      [[
      if(<>)
      {
          <>
      }  
      else if(<>)
      {
          <>
      }  
      else
      {
          <>
      }
      ]],
      { i(1, 'condition'), i(2, 'body'), i(3, 'condition'), i(4, 'body'), i(5, 'body') },
      {}
    )
  ),
  --s(
  --  { trig = 'sw', dscr = 'switch expression' },
  --  fmta(
  --    [[
  --
  --    ]],
  --    { i(1) },
  --    {}
  --  )
  --),
  --s(
  --  { trig = 'test', dscr = 'simple unit test with given when then' },
  --  fmta(
  --    [[
  --
  --    ]],
  --    { i(1) },
  --    {}
  --  )
  --),
  s({ trig = 'prop', dscr = 'public property with getter and setter' }, {
    t 'public ',
    i(1, 'type'),
    t ' ',
    i(2, 'name'),
    t ' { get; set; }',
  }),
  s({ trig = 'rprop', dscr = 'public property with getter and private setter' }, {
    t 'public ',
    i(1, 'type'),
    t ' ',
    i(2, 'name'),
    t ' { get; private set; }',
  }),
  s({ trig = 'rf', dscr = 'private readonly field' }, {
    t 'private readonly ',
    i(1, 'type'),
    t ' _',
    i(2, 'name'),
    t ';',
  }),
}
