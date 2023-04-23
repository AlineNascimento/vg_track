defmodule VgTrack.Games.Games do

  import Ecto.Query, warn: false

  alias VgTrack.Games.Game
  alias VgTrack.Repo

  def create_game(attrs \\ %{}) do
    %Game{}
    |> Game.changeset(attrs)
    |> Repo.insert()
  end

  def get_game!(id), do: Repo.get!(Game, id)

  def list_games() do
    Repo.all(Game)
  end

   def update_game(%Game{} = game, attrs) do
    game
    |> Game.changeset(attrs)
    |> Repo.update()
  end

  def change_game(%Game{} = game, attrs \\ %{}) do
    Game.changeset(game, attrs)
  end

  def delete_game(%Game{} = game) do
    Repo.delete(game)
  end
end
