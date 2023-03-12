defmodule VgTrackWeb.UsersGamesView do
  use VgTrackWeb, :view

  alias VgTrackWeb.UsersGamesView

  def render("index.json", %{games: games}) do
    render_many(games, GameView, "users_games.json")
  end

  def render("show.json", %{users_games: users_games}) do
    render_one(users_games, UsersGamesView, "users_games.json")
  end

  def render("users_games.json", %{users_games: users_games}) do
    %{
      id: users_games.id,
      user_id: users_games.user_id,
      game_id: users_games.game_id,
      console_id: users_games.console_id,
      completed: users_games.completed
    }
  end

  # Render list of game data

  def render("games_list.json", %{games_list: games_list}) do
    render_many(games_list, UsersGamesView, "game.json", as: :game)
  end

  def render("show_game.json", %{game: game}) do
    render_one(game, UsersGamesView, "game.json")
  end

  def render("game.json", %{game: game}) do
    %{
        users_games_id: game.users_games_id,
        title: game.title,
        year: game.year,
        name: game.name,
        completed_at: game.completed_at,
        completed: game.completed,
        level: game.level,
        personal_notes: game.personal_notes
      }
  end
end
