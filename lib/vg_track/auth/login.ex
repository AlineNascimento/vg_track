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
end
