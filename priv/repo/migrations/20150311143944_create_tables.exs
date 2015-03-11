defmodule EctoStuff.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:birds) do
      add :name,      :string
      add :size,      :string
      add :call_type, :string
    end
  end
end
