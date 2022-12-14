defmodule VgTrack.Users.User do
  @moduledoc """
  The User Struct
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias __MODULE__

  @type t :: %__MODULE__{
    id: integer(),
    name: binary(),
    email: binary(),
    password: binary(),
    inserted_at: NaiveDateTime.t(),
    updated_at: NaiveDateTime.t()
  }

  @required_fields ~w(email)

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> unique_constraint([:email], name: "users_email_index")
  end

end
