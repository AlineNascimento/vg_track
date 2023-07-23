defmodule VgTrackWeb.UsersGamesController do
  use VgTrackWeb, :controller

  alias VgTrack.Users.Users
  alias VgTrack.Users.User
  alias VgTrack.Games.Games
  alias VgTrack.Games.Game
  alias VgTrack.UsersGames.UserGame
  alias VgTrack.UsersGames.UsersGames
  alias VgTrack.Business.Business

  # def index(conn, _params) do
  #   games = Games.list_games()
  #   render(conn, "index.json", games: games)
  # end

  # Create game and user_game
  def create(conn, params) do
    game_params = %{
      "title" => params["title"],
      "year" => params["year"],
      "console_id" => params["console_id"]
    }

    user_game_params = %{
      "user_id" => params["user_id"],
      "completed" => params["completed"],
      "completed_at" => params["completed_at"],
      "level" => params["level"],
      "personal_notes" => params["personal_notes"]
    }

    with {:ok, %Game{} = game} <- Games.create_game(game_params),
         user_game_params <- Map.put(user_game_params, "game_id", game.id),
         {:ok, %UserGame{} = users_games} <- UsersGames.create_user_game(user_game_params),
         users_games_group_data <- Business.group_game_data(users_games.id) do
      IO.inspect(users_games)

      conn
      |> put_status(:created)
      |> render("show.json", users_games: users_games)
    end
  end

  def delete(conn, params) do
    with game <- Games.get_game!(params["game_id"]),
         user_game <- UsersGames.get_relation(params["user_id"], params["game_id"]),
         user_game_game <- UsersGames.delete_user_game(%{"id" => user_game.id}),
         game_game <- Games.delete_game(game) do
      send_resp(conn, :no_content, "")
    end
  end

  # def show(conn, %{"id" => id}) do
  #   game = Games.get_game!(id)
  #   render(conn, "show.json", game: game)
  # end

  # def update(conn, game_params) do
  #   game = Games.get_game!(conn.path_params["id"])

  #   with {:ok, %Game{} = game} <- Games.update_game(game, game_params) do
  #     render(conn, "show.json", game: game)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   game = Games.get_game!(id)

  #   with {:ok, %Game{}} <- Games.delete_game(game) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end

  def list_games_user(conn, params) do
    with {:ok, user} <- Users.get_user(%{"id" => params["user_id"]}),
         games_list <- Business.list_group_game_data(user.id) do
      render(conn, "games_list.json", games_list: games_list)
    end
  end

  def list_games_user_filtered(conn, params) do
    with {:ok, user} <- Users.get_user(%{"id" => params["user_id"]}),
         filtered_games_list <- Business.list_user_related_games(user.id, params["filter_param"]) do
      render(conn, "games_list.json", games_list: filtered_games_list)
    end
  end

  # Filtrar o nome do jogo e alguns campos de user_game
end
