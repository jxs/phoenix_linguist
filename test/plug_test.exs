Code.require_file "test/fixtures/error_view.exs"

defmodule PhoenixLinguistPlugTest do
  use ExUnit.Case
  use Plug.Test

  import Plug.Conn

  setup_all do
    Application.put_env(:phoenix_linguist, __MODULE__, %{i18n: PhoenixLinguistTest.I18n})
    :ok
  end

  setup do
    conn = conn(:get, "/")
    conn = %Plug.Conn{conn | params: %{}, private: %{phoenix_endpoint: __MODULE__, plug_session: %{}}}
    {:ok, conn: conn}
  end

  #mock phoenix config function
  def config(_) do
    PhoenixLinguistPlugTest.ErrorView
  end

  test "plug call puts default locale if prefered_local returns :nil", context do
    conn = PhoenixLinguist.Plug.call(context.conn, [])
    assert get_session(conn, "locale") == "fr"
  end

  test "plug call puts locale if prefered_local returns that locale", context do
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "en"}}
    conn = PhoenixLinguist.Plug.call(conn, [])
    assert get_session(conn, "locale") == "en"
  end

  test "plug call puts 404 status and renders ErrorView if prefered_local returns :wrong", context do
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "pt"}}
    conn = PhoenixLinguist.Plug.call(conn, [])
    assert conn.resp_body == "Page not found - 404"
    assert conn.halted
  end
end
