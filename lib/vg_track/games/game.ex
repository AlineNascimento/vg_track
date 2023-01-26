defmodule VgTrack.Games.Game do
  use Ecto.Schema
  import Ecto.Changeset

  alias VgTrack.Consoles.Console
  alias __MODULE__

  @type t :: %__MODULE__{
    id: integer(),
    title: binary(),
    year: binary(),
    console_id: integer(),
    inserted_at: NaiveDateTime.t(),
    updated_at: NaiveDateTime.t()
  }

  schema "games" do
    field :title, :string
    field :year, :string

    belongs_to(:console, Console)
    timestamps()
  end

  def changeset(game, attrs) do
    game
    |> cast(attrs, [:title, :year, :console_id])
    |> validate_required([:title, :year, :console_id])
    |> unique_constraint([:title, :year], name: "games_title_year_index")
  end

end
