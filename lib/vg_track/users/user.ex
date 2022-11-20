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

  schema "users" do
    field :name, :string
    field :email, :string
    field :password, :string

    timestamps()
  end

  def changeset(user, attrs) do
    IO.inspect(user)
    IO.puts("Dentro do Changeset")
    IO.inspect(attrs)
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> unique_constraint([:email], name: "users_email_index")
  end

end
