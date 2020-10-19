defmodule UnbiasBackend.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :age, :integer
      add :name, :string
      add :birthday, :naive_datetime
      add :location, :string
      add :favorites, {:array, :string}
      add :race, {:array, :string}
      add :gender, :string
      add :email, :string
      add :password, :string
      add :token, :string
      add :avatar, :string

      timestamps()
    end

  end
end
