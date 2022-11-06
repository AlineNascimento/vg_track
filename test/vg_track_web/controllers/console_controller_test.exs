defmodule VgTrackWeb.ConsoleControllerTest do
  use VgTrackWeb.ConnCase

  import VgTrack.ConsolesFixtures

  alias VgTrack.Consoles.Console

  @create_attrs %{
    name: "some name"
  }
  @update_attrs %{
    name: "some updated name"
  }
  @invalid_attrs %{name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all consoles", %{conn: conn} do
      conn = get(conn, Routes.console_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create console" do
    test "renders console when data is valid", %{conn: conn} do
      conn = post(conn, Routes.console_path(conn, :create), console: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.console_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.console_path(conn, :create), console: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update console" do
    setup [:create_console]

    test "renders console when data is valid", %{conn: conn, console: %Console{id: id} = console} do
      conn = put(conn, Routes.console_path(conn, :update, console), console: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.console_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, console: console} do
      conn = put(conn, Routes.console_path(conn, :update, console), console: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete console" do
    setup [:create_console]

    test "deletes chosen console", %{conn: conn, console: console} do
      conn = delete(conn, Routes.console_path(conn, :delete, console))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.console_path(conn, :show, console))
      end
    end
  end

  defp create_console(_) do
    console = console_fixture()
    %{console: console}
  end
end
