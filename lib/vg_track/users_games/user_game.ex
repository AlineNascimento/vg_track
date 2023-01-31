defmodule VgTrack.UsersGames.UserGame do
  @moduledoc """
  The User Struct
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  @type t :: %__MODULE__{
    id: integer(),
    user_id: integer(),
    game_id: integer(),
    completed_at: NaiveDateTime.t(),
    completed: boolean(),
    level: binary(),
    personal_notes: binary(),
    inserted_at: NaiveDateTime.t(),
    updated_at: NaiveDateTime.t()
  }

  schema "user_game" do
    field :completed_at, :naive_datetime
    field :completed, :boolean
    field :level, :string
    field :personal_notes, :string

    belongs_to(:user, User)
    belongs_to(:game, Game)
    timestamps()
  end

  def changeset(user_game, attrs) do
    user_game
    |> cast(attrs, [:completed, :level, :personal_notes, :user_id, :game_id])
    |> validate_required([:completed, :level, :user_id, :game_id])
    |> unique_constraint([:user_id, :game_id], name: "user_game_user_id_game_id_index")
  end

end
