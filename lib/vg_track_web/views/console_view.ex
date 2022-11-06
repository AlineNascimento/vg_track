defmodule VgTrackWeb.ConsoleView do
  use VgTrackWeb, :view
  alias VgTrackWeb.ConsoleView

  def render("index.json", %{consoles: consoles}) do
    %{data: render_many(consoles, ConsoleView, "console.json")}
  end

  def render("show.json", %{console: console}) do
    %{data: render_one(console, ConsoleView, "console.json")}
  end

  def render("console.json", %{console: console}) do
    %{
      id: console.id,
      name: console.name
    }
  end
end
