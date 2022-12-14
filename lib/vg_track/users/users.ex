defmodule VgTrack.Users.Users do
  @moduledoc """
  The User context
  """

  import Ecto.Query, warn: false

  alias VgTrack.Users.User
  alias VgTrack.Repo

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
