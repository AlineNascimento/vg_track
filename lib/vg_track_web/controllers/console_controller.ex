defmodule VgTrackWeb.ConsoleController do
  use VgTrackWeb, :controller

  alias VgTrack.Consoles.Consoles
  alias VgTrack.Consoles.Console

  action_fallback VgTrackWeb.FallbackController

  def index(conn, _params) do
    consoles = Consoles.list_consoles()
    render(conn, "index.json", consoles: consoles)
  end

  def create(conn, console_params) do
    with {:ok, %Console{} = console} <- Consoles.create_console(console_params) do
      IO.inspect(console_params)
      IO.inspect(console)
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.console_path(conn, :show, console))
      |> render("show.json", console: console)
    end
  end

  def show(conn, %{"id" => id}) do
    console = Consoles.get_console!(id)
    render(conn, "show.json", console: console)
  end

  def update(conn, %{"id" => id, "console" => console_params}) do
    console = Consoles.get_console!(id)

    with {:ok, %Console{} = console} <- Consoles.update_console(console, console_params) do
      render(conn, "show.json", console: console)
    end
  end

  def delete(conn, %{"id" => id}) do
    console = Consoles.get_console!(id)

    with {:ok, %Console{}} <- Consoles.delete_console(console) do
      send_resp(conn, :no_content, "")
    end
  end
end
