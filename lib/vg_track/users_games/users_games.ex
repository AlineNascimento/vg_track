defmodule VgTrack.UsersGames.UsersGames do
  @moduledoc """
  The User context
  """

  import Ecto.Query, warn: false

  alias VgTrack.UsersGames.UserGame
  alias VgTrack.Repo

  def create_user_game(attrs \\ %{}) do
    %UserGame{}
    |> UserGame.changeset(attrs)
    |> Repo.insert()
  end

  def get_user_game!(%{"id" => id}) do
    Repo.get!(UserGame, id)
  end

  def get_relation(user_id, game_id)  do
    from( user_game in UserGame, where: user_game.user_id == ^user_id and user_game.game_id == ^game_id)
    |> Repo.one()
  end

  def delete_user_game(%{"id" => id}) do
    user_game = Repo.get!(UserGame, id)
    Repo.delete(user_game)
  end

  def list_users_games() do
    Repo.all(UserGame)
  end

  def list_user_games(user_id) do
    from( user_game in UserGame, where: user_game.user_id == ^user_id )
    |> Repo.all()
  end

  def list_game_users(game_id) do
    from( user_game in UserGame, where: user_game.game_id == ^game_id )
    |> Repo.all()
  end

  def update_user_game(attrs) do
    user_game = Repo.get(UserGame, attrs["id"])
    |> User.changeset(attrs)
    |> Repo.update()
  end
end
