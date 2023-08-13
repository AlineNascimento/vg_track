defmodule VgTrack.Auth.Login do
  @moduledoc """
  The Login context
  """

  import Ecto.Query, warn: false

  alias VgTrack.Users.User
  alias VgTrack.Repo

  def login(attrs) do
    with %User{} = user when not is_nil(user) <- Repo.get_by(User, email: attrs["email"]),
         true <- user.password == attrs["password"] do
      {:ok, %{session_id: "session_id", user_name: user.name, user_email: user.email}}
    else
      nil ->
        {:error, :not_found}

      false ->
        {:error, :not_found}
    end
  end

  # VgTrack.Auth.Login.login(%{ "email" => "email@email.com.wkjlo,mns0", "password" => "123"})

  def create_user(attrs \\ %{}) do
    IO.inspect(attrs)

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(%{"id" => id}) do
    IO.inspect(Repo.get(User, id))

    case Repo.get(User, id) do
      %User{} = user ->
        {:ok, user}

      nil ->
        {:error, :not_found}
    end
  end

  def get_user!(%{"id" => id}) do
    Repo.get!(User, id)
  end

  def delete_user(%{"id" => id}) do
    user = Repo.get!(User, id)
    Repo.delete(user)
  end

  def list_users() do
    Repo.all(User)
  end

  def update_user(attrs) do
    user =
      Repo.get(User, attrs["id"])
      |> User.changeset(attrs)
      |> Repo.update()
  end
end
