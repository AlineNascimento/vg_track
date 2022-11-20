defmodule VgTrack.Consoles.Console do
  use Ecto.Schema
  import Ecto.Changeset

  schema "consoles" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(console, attrs) do
    IO.inspect(console)
    console
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
