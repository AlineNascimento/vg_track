defmodule VgTrackWeb.SessionController do
  use VgTrackWeb, :controller

  alias VgTrack.Sessions.Sessions
  alias VgTrack.Sessions.Session

  def create(conn, params) do
    with {:ok, %Session{} = session} <- Sessions.create_session(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.console_path(conn, :show, session))
      |> render("show.json", session: session)
    end
  end

  # def show(conn, params) do
  #   session = Sessions.get_session!(params)
  #   render(conn, "show.json", session: session)
  # end

  def delete(conn, params) do
    with {:ok, %Session{} = session} <- Sessions.delete_user(params) do
      send_resp(conn, :no_content, "")
    end
  end

  # def index(conn, _params) do
  #   sessions = Sessions.list_sessions()
  #   render(conn, "index.json", sessions: sessions)
  # end

  def update(conn, params) do
    with {:ok, %Session{} = session} <- Sessions.update_user(params) do
      render(conn, "show.json", session: session)
    end
  end
end
