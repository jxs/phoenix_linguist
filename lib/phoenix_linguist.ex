defmodule PhoenixLinguist do
  @moduledoc """
  module that helps integrating linguist into phoenix

  """

  import Plug.Conn, only: [get_req_header: 2, get_session: 2, put_session: 3]
  import Phoenix.Controller, only: [endpoint_module: 1]

  @doc """
  get the prefered locale based on the input locale, session and accept-language request header

  return nil if there's none and :wrong if the params_locale doesn't exist
  """
  def prefered_locale(conn) do
    cond do
      params_locale(conn) ->
        params_locale(conn)
      session_locale(conn) ->
        session_locale(conn)
      req_header_locale(conn) ->
        req_header_locale(conn)
      true ->
        nil
    end
  end

  @doc """
  check if given locale exists

  """
  def params_locale(conn) do
    locale = conn.params["locale"]
    cond do
      locale && locale in i18n(conn).locales ->
        locale
      locale && not locale in i18n(conn).locales ->
        :wrong
      true ->
        nil
    end
  end


  @doc """
  get the default locale

  """
  def default_locale(conn) do
    #locales come reversed, so we get last instead
    i18n(conn).locales |> List.last()
  end

  @doc """
  return if exists an already set location in the session

  """
  def session_locale(conn) do
    get_session conn, "locale"
  end

  @doc """
   match the prefered locale based on the accept_language http request header, and the existing I18n locales
   return nil if none

   """
  def req_header_locale(conn) do
    accept_language = get_req_header(conn, "accept-language")
    if not Enum.empty?(accept_language) do
      accept_language = List.first(accept_language)
      matches = Regex.scan(~r/[a-z]{2,8}/, accept_language) |> List.flatten
      Enum.find matches, fn(x) -> x in i18n(conn).locales end
    end
  end

  @doc """
  get application's I18n module

  """
  def i18n(conn) do
    Mix.Project.config()[:app]
    |> Application.get_env(endpoint_module(conn))
    |> Dict.get(:i18n)
  end

end
