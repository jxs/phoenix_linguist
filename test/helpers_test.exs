defmodule PhoenixLinguistHelpersTest do
  use ExUnit.Case

  import PhoenixLinguist.Helpers

  setup_all do
    Application.put_env(:phoenix_linguist, PhoenixLinguist, %{i18n: PhoenixLinguistTest.I18n})
    :ok
  end

  setup do
    conn = %Plug.Conn{params: %{}, private: %{phoenix_endpoint: PhoenixLinguist, plug_session: %{}}}
    {:ok, conn: conn}
  end

  test "t defaults to default locale when none availavble", context do
    assert t(context.conn, "flash.notice.hello") == "salut"
  end

  test "t! defaults to default locale when none availavble", context do
    assert t!(context.conn, "flash.notice.hello") == "salut"
  end

  test "t returns empty string when there's no translation", context do
    assert t(context.conn, "flash.notice.bye") == ""
  end

  test "t! raises exception  when there's no translation", context do
    assert_raise Linguist.NoTranslationError, fn ->
      t!(context.conn, "flash.notice.bye")
    end
  end

  test "l returns default locale if prefered_locale is not available", context do
    assert l(context.conn) == "fr"
  end

end
