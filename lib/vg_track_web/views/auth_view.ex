defmodule VgTrackWeb.AuthView do
  use VgTrackWeb, :view
  alias VgTrackWeb.AuthView

  def render("show.json", %{login_params: login_params}) do
    IO.puts("two:")
    IO.inspect(login_params)
    %{data: render_one(login_params, AuthView, "login_params.json")}
  end

  def render("login_params.json", %{login_params: login_params}) do
    %{
      session_id: login_params.session_id,
      email: login_params.user_email,
      name: login_params.user_name
    }
  end
end
