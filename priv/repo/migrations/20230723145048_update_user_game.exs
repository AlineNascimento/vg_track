defmodule VgTrack.Repo.Migrations.UpdateUserGame do
  use Ecto.Migration

  def change do
    alter table(:user_game) do
      modify :completed_at, :string, null: true
    end
  end
end
