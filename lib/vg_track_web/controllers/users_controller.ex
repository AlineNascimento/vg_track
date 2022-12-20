defmodule VgTrackWeb.UsersController do
  use VgTrackWeb, :controller

  alias VgTrack.Users.Users
  alias VgTrack.Users.User

  def create(conn, params) do

    with {:ok, %User{} = users} <- Users.create_user(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.console_path(conn, :show, users))
      |> render("show.json", users: users)
    end
  end

  def show(conn, params) do
    user = Users.get_user!(params)
    render(conn, "show.json", users: user)
  end
end
