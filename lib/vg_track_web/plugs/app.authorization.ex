defmodule VgTrackWeb.Plugs.AppAuthorization do
  import Plug.Conn
  import Ecto.Query

  alias VgTrack.Sessions.Sessions

  def init(opts) do
    opts
  end

  def call(conn, opts) do
    with {:ok, session} <- Sessions.verify_session(opts) do
      conn
      |> put_status(200)
    else
      _ ->
        unauthorized(conn)
    end
  end

  defp unauthorized(conn) do
    conn
    |> send_resp(
      :unauthorized,
      Poison.encode!(%{error: "user do not have access to application"})
    )
    |> halt()
  end
end
