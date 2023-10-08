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

  # before_insert Session, :generate_session_token
  # before_insert do
  #     %Session{session_token: nil} = changeset
  #     changeset
  #     |> Ecto.Changeset.put_change(:session_token, generate_session_token())
  # end

  def changeset(session, attrs) do
    IO.puts("aqui:")
    IO.inspect(attrs)
    session
    |> cast(attrs, [:user_id])
    |> validate_required([:user_id])
    |> generate_session_token()
  end

  defp generate_session_token(changeset) do
    session_token = :crypto.strong_rand_bytes(32) |> Base.encode64()
    Ecto.Changeset.put_change(changeset, :session_token, session_token)
  end



  # Para casa:
  # Gerando session_token  criptografado: defp generate_session_token do
  #   :crypto.strong_rand_bytes(32) |> Base.encode64()
  # end

  #  Antes de criar um novo registro utiliz a função:
  #  before_insert do
  #     %User{session_token: nil} = changeset
  #     changeset
  #     |> Ecto.Changeset.put_change(:session_token, generate_session_token())
  #   end
end
