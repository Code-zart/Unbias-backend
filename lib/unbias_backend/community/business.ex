defmodule UnbiasBackend.Community.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :category, {:array, :string}
    field :location, :string
    field :minority, :boolean, default: false
    field :name, :string
    field :price, :integer
    field :rating, :float

    timestamps()
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:name, :location, :minority, :category, :rating, :price])
    |> validate_required([:name, :location, :minority, :category, :rating, :price])
  end
end
