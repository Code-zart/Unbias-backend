defmodule UnbiasBackend.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :age, :integer
    field :avatar, :string
    field :birthday, :naive_datetime
    field :email, :string
    field :favorites, {:array, :string}
    field :gender, :string
    field :location, :string
    field :name, :string
    field :password, :string
    field :race, {:array, :string}
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:age, :name, :birthday, :location, :favorites, :race, :gender, :email, :password, :token, :avatar])
    |> validate_required([:age, :name, :birthday, :location, :favorites, :race, :gender, :email, :password, :token, :avatar])
  end
end
