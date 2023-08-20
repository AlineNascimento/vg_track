defmodule VgTrack.Repo.Migrations.Sessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :user_id, references(:users)
      add :session_token, :string, null: false

      timestamps()
    end
  end
end
