defmodule Omnitracks.Repo.Migrations.CreateWeightEntries do
  use Ecto.Migration

  def change do

    create table(:weight_entries) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :date, :date
      add :weight, :float
      timestamps()
    end

  end
end
