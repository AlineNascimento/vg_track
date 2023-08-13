defmodule VgTrackWeb.AuthController do
  use VgTrackWeb, :controller

  alias VgTrack.Auth.Login
  alias VgTrack.Users.Users
  alias VgTrack.Users.User

  def create(conn, params) do
    with {:ok, login_params} <- Login.login(params) do
      IO.inspect(login_params)
      conn
      |> put_status(:created)
      # |> put_resp_header("location", Routes.console_path(conn, :show, login_params))
      |> render("show.json", login_params: login_params)
    end
  end
end
