defmodule VgTrackWeb.SessionView do
  use VgTrackWeb, :view
  alias VgTrackWeb.SessionView

  def render("index.json", %{sessions: sessions}) do
    %{data: render_many(sessions, SessionView, "session.json")}
  end

  def render("show.json", %{session: session}) do
    %{data: render_one(session, SessionView, "session.json")}
  end

  def render("session.json", %{session: session}) do
    %{
      id: session.id,
      user_id: session.user_id
    }
  end
end
