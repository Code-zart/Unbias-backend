defmodule UnbiasBackend.CommunityTest do
  use UnbiasBackend.DataCase

  alias UnbiasBackend.Community

  describe "businesses" do
    alias UnbiasBackend.Community.Business

    @valid_attrs %{category: [], location: "some location", minority: true, name: "some name", price: 42, rating: 120.5}
    @update_attrs %{category: [], location: "some updated location", minority: false, name: "some updated name", price: 43, rating: 456.7}
    @invalid_attrs %{category: nil, location: nil, minority: nil, name: nil, price: nil, rating: nil}

    def business_fixture(attrs \\ %{}) do
      {:ok, business} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Community.create_business()

      business
    end

    test "list_businesses/0 returns all businesses" do
      business = business_fixture()
      assert Community.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business = business_fixture()
      assert Community.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      assert {:ok, %Business{} = business} = Community.create_business(@valid_attrs)
      assert business.category == []
      assert business.location == "some location"
      assert business.minority == true
      assert business.name == "some name"
      assert business.price == 42
      assert business.rating == 120.5
    end

    test "create_business/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Community.create_business(@invalid_attrs)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      assert {:ok, %Business{} = business} = Community.update_business(business, @update_attrs)
      assert business.category == []
      assert business.location == "some updated location"
      assert business.minority == false
      assert business.name == "some updated name"
      assert business.price == 43
      assert business.rating == 456.7
    end

    test "update_business/2 with invalid data returns error changeset" do
      business = business_fixture()
      assert {:error, %Ecto.Changeset{}} = Community.update_business(business, @invalid_attrs)
      assert business == Community.get_business!(business.id)
    end

    test "delete_business/1 deletes the business" do
      business = business_fixture()
      assert {:ok, %Business{}} = Community.delete_business(business)
      assert_raise Ecto.NoResultsError, fn -> Community.get_business!(business.id) end
    end

    test "change_business/1 returns a business changeset" do
      business = business_fixture()
      assert %Ecto.Changeset{} = Community.change_business(business)
    end
  end
end
