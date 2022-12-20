defmodule VgTrack.Users.Users do
  @moduledoc """
  The Users context
  """

  import Ecto.Query, warn: false

  alias VgTrack.Users.User
  alias VgTrack.Repo

  def create_user(attrs \\ %{}) do
    IO.inspect(attrs)
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def update_console(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def list_consoles do
    Repo.all(User)
  end

end
