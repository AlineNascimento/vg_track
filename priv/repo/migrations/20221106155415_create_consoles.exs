defmodule VgTrack.Repo.Migrations.CreateConsoles do
  use Ecto.Migration

  def change do
    create table(:consoles) do
      add :name, :string

      timestamps()
    end
  end
end
