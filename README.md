[![Build Status](https://travis-ci.org/jxs/phoenix_linguist.svg?branch=master)](https://travis-ci.org/jxs/phoenix_linguist)

# PhoenixLinguist

A project that integrates [Phoenix](http://github.com/phoenixframework/phoenix) with [Linguist](https://github.com/chrismccord/linguist), providing a plug and view helpers

`PhoenixLinguistPlug` checks if there's a :locale param on the requested route, if there is and matches the existing locales, puts the locale on the session. If the requested :locale does not exist, forwards the user to the `ErrorView` `404` handler defined. If there isn't a :locale defined, `PhoenixLinguistPlug` puts the default locale on the session
`PhoenixLinguist.Helpers` are a couple of view helpers that can be used on templates to help determine user's prefered locale

You can see the [online documentation](http://hexdocs.pm/phoenix_linguist/) for more information.

## Requirements

Elixir 1.0.2

[Phoenix](http://www.phoenixframework.org) 0.10.0

## Instructions

Define your I18n Module on `config.ex` next to other Endpoint Settings

```elixir
config :my_app, MyApp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "l6M/YRIzkiqMk5Irn9UNm7ANo1BoHIF0XchxNmcUJWhdKZdERA45ASDFIxZ",
  debug_errors: false,
  i18n: MyApp.I18n
```

Add `PhoenixLinguist.Plug` to the plug list on your routes file, on the browser pipeline after Phoenix plugs

```elixir
  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug PhoenixLinguist.Plug
  end
```

If you need to use the helper functions, add `PhoenixLinguist.Helpers` to your web module:

```elixir
  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      import MyAPP.Router.Helpers
      use Phoenix.HTML
      import PhoenixLinguist.Helpers
    end
  end

```

Check the [online documentation](http://hexdocs.pm/phoenix_linguist/PhoenixLinguist.Helpers.html) for the list of helpers available
