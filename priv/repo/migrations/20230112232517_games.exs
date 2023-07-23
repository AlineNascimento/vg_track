defmodule VgTrack.Repo.Migrations.Games do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :title, :string, null: false
      add :year, :string, null: false
      add :console_id, references(:consoles)

      timestamps()
    end

    create index("games", [:title, :year], unique: true)
  end
end
