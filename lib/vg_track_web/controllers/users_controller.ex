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

  def delete(conn, params) do
    with {:ok, %User{} = users} <- Users.delete_user(params) do
      send_resp(conn, :no_content, "")
    end
  end

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   IO.inspect(id)
  #   IO.inspect(user_params)
  #   with {:ok, %User{} = user} <- Users.update_user(id, user_params) do
  #     render(conn, "show.json", users: user)
  #   end
  # end

  def update(conn, params) do
    # IO.inspect(user_params)
    # IO.inspect(some_params)

    with {:ok, %User{} = user} <- Users.update_user(params) do
      render(conn, "show.json", users: user)
    end
  end
end
