defmodule VgTrackWeb.GameView do
  use VgTrackWeb, :view

  alias VgTrackWeb.GameView

  def render("index.json", %{games: games}) do
    render_many(games, GameView, "game.json")
  end

  def render("show.json", %{game: game}) do
    render_one(game, GameView, "game.json")
  end

  def render("game.json", %{game: game}) do
    %{
      id: game.id,
      title: game.title,
      year: game.year,
      console_id: game.console_id
    }
  end
end
