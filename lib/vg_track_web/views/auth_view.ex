defmodule VgTrackWeb.AuthView do
  use VgTrackWeb, :view
  alias Hex.API.Auth
  alias VgTrackWeb.AuthView

  def render_one(login_params, _opts) do
    %{session_id: session_id, user_name: user_name, user_email: user_email} = login_params

    %{
      "id" => session_id,
      "name" => user_name,
      "email" => user_email
    }
  end

  def render("show.json", %{login_params: login_params}) do
     render_one(login_params, AuthView)
  end

  # def render("login_params.json", %{login_params: login_params}) do
  #   IO.puts('here abc')
  #   %{
  #     session_id: login_params.session_id,
  #     email: login_params.user_email,
  #     name: login_params.user_name
  #   }
  # end
end
