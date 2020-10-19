defmodule UnbiasBackend.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :name, :string
      add :location, :string
      add :minority, :boolean, default: false, null: false
      add :category, {:array, :string}
      add :rating, :float
      add :price, :integer

      timestamps()
    end

  end
end
