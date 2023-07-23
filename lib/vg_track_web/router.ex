defmodule VgTrackWeb.Router do
  use VgTrackWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", VgTrackWeb do
    pipe_through :api

    resources "/consoles", ConsoleController, except: [:new, :edit]
    resources "/users", UsersController, except: [:new, :edit]
    resources "/games", GameController, except: [:new, :edit]
    get "/users_games/user_id/:user_id", UsersGamesController, :list_games_user
    post "/users_games", UsersGamesController, :create
    delete "/users_games/:user_id/:game_id", UsersGamesController, :delete

    get "/users_games/user_id/:user_id/:filter_param",
        UsersGamesController,
        :list_games_user_filtered
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: VgTrackWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
