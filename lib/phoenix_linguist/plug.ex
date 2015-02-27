defmodule PhoenixLinguist.Plug do
  @moduledoc """
  Plug to check if the locale the user is trying exists, if not forward to 404

  """

  import Plug.Conn, only: [halt: 1, put_status: 2, put_session: 3]
  import Phoenix.Controller, only: [endpoint_module: 1, render: 2, put_view: 2]
  import PhoenixLinguist, only: [prefered_locale: 1, default_locale: 1]


  def init(options) do
    options
  end

  def call(conn, opts) do
    case prefered_locale(conn) do
      :wrong ->
        error_view = endpoint_module(conn).config(:render_errors)
        conn
        |> put_status(404)
        |> put_view(error_view)
        |> render("404.html")
        |> halt
      nil ->
        put_session conn, "locale", default_locale(conn)
      locale ->
        put_session conn, "locale", locale
    end
  end


end
