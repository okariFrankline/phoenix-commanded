defmodule Turbo.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks, primary_key: false) do
      add :uuid, :binary_id, primary_key: true
      add :title, :string
      add :due_date, :date

      timestamps()
    end
  end
end
