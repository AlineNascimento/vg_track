defmodule VgTrack.Repo.Migrations.UserGame do
  use Ecto.Migration

  def change do
    create table(:user_game) do
      add :completed, :boolean, null: false
      add :level, :string, null: false
      add :personal_notes, :string
      add :completed_at, :naive_datetime
      add :user_id, references(:users)
      add :game_id, references(:games)

      timestamps()
    end

    create index("user_game", [:user_id, :game_id], unique: true)
  end
end
