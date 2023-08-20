defmodule VgTrack.Sessions.Session do
  @moduledoc """
  The Session Struct
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias VgTrack.Sessions.Session
  alias VgTrack.Users.User
  alias __MODULE__

  @type t :: %__MODULE__{
          id: integer(),
          user_id: integer(),
          session_token: binary(),
          inserted_at: NaiveDateTime.t(),
          updated_at: NaiveDateTime.t()
        }

  schema "sessions" do
    field :session_token, :string

    belongs_to(:user, User)
    timestamps()
  end

  def changeset(session, attrs) do
    session
    |> cast(attrs, [:user_id, :session_token])
    |> validate_required([:user_id, :session_token])
  end
end
