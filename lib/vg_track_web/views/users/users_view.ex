defmodule VgTrackWeb.UsersView do
  use VgTrackWeb, :view
  alias VgTrackWeb.UsersView


  def render("show.json", %{users: users}) do
    %{data: render_one(users, UsersView, "users.json")}
  end

  def render("users.json", %{users: users}) do
    %{
      id: users.id,
      name: users.name,
      email: users.email
    }
  end
end
