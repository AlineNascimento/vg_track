defmodule VgTrack.ConsolesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VgTrack.Consoles` context.
  """

  @doc """
  Generate a console.
  """
  def console_fixture(attrs \\ %{}) do
    {:ok, console} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> VgTrack.Consoles.create_console()

    console
  end
end
