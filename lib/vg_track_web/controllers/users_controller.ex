defmodule VgTrackWeb.UsersController do
  use VgTrackWeb, :controller

  alias VgTrack.Users.Users
  alias VgTrack.Users.User

  def create(conn, params) do

    with {:ok, %User{} = user} <- Users.create_user(params) do
      conn
      |> put_status(:created)
      |> render("show.json", user: user)
    end
  end
end
