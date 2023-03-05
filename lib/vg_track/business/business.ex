defmodule VgTrack.Business.Business do
  @moduledoc """
  The User context
  """
  import Ecto.Query, warn: false

  alias VgTrack.UsersGames.UserGame
  alias VgTrack.Consoles.Console
  alias VgTrack.Games.Game
  # alias VgTrack.UsersGames.UsersGames
  # alias VgTrack.Consoles.Consoles
  # alias VgTrack.Games.Games
  alias VgTrack.Repo

  def group_game_data(users_games_id) do
    from(user_game in UserGame,
      join: game in Game,
      on: user_game.game_id == game.id,
      join: console in Console,
      on: game.console_id == console.id,
      where: user_game.id == ^users_games_id,
      select: %{
        users_games_id: user_game.id,
        title: game.title,
        year: game.year,
        name: console.name,
        completed_at: user_game.completed_at,
        completed: user_game.completed,
        level: user_game.level,
        personal_notes: user_game.personal_notes
      }
    )
    |> Repo.one()
  end

  # def group_game_data(users_games_id) do
  #   with user_game <- UsersGames.get_user_game!(%{"id" => users_games_id}),
  #        game <- Games.get_game!(user_game.game_id),
  #        console <- Consoles.get_console!(game.console_id) do
  #     %{
  #       users_games_id: user_game.id,
  #       title: game.title,
  #       year: game.year,
  #       name: console.name,
  #       completed_at: user_game.completed_at,
  #       completed: user_game.completed,
  #       level: user_game.level,
  #       personal_notes: user_game.personal_notes
  #     }
  #   end
  # end

  def list_group_game_data(user_id) do
    IO.inspect(user_id)
    from(user_game in UserGame,
      join: game in Game,
      on: user_game.game_id == game.id,
      join: console in Console,
      on: game.console_id == console.id,
      where: user_game.user_id == ^user_id,
      select: %{
        users_games_id: user_game.id,
        title: game.title,
        year: game.year,
        name: console.name,
        completed_at: user_game.completed_at,
        completed: user_game.completed,
        level: user_game.level,
        personal_notes: user_game.personal_notes
      }
    )
    |> Repo.all()
  end
end
