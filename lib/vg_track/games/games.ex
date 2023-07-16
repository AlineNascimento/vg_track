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

  def get_games_with_title(title, users_games) do
    format_title = "%" <> title <> "%"

    complete_data_list =
      Enum.map(users_games, fn map ->
        game = query_game_by_title_and_id(format_title, map.game_id)
        # IO.puts('smurf:')
        # IO.inspect(map)

        # IO.puts('games:')
        # IO.inspect(game)
        # Map.put(map, :console_name, console.name)
        # TODO: - Ajustar/validar se o jogo é criado quando é criado o user_game
        # case !!game do
        #   true ->
        # Map.merge(map, game)
        #   false ->
        #     nil
        # end
      end)

    Enum.filter(complete_data_list, fn map ->
      # Map.put(map, :console_name, console.name)
      # TODO: - Ajustar/validar se o jogo é criado quando é criado o user_game
      # case !!game do
      #   true ->
      # Map.merge(map, game)
      #   false ->
      #     false
      # end
    end)

    # from(game in Game,
    #   where:
    #     ilike(game.title, ^format_title) and
    #       game.id in ^games_ids
    # )
    # |> Repo.all()
  end

  def query_game_by_title_and_id(format_title, game_id) do
    from(game in Game,
      where:
        ilike(game.title, ^format_title) and
          game.id == ^game_id
    )
    |> Repo.one()
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
