defmodule UnbiasBackendWeb.BusinessControllerTest do
  use UnbiasBackendWeb.ConnCase

  alias UnbiasBackend.Community
  alias UnbiasBackend.Community.Business

  @create_attrs %{
    category: [],
    location: "some location",
    minority: true,
    name: "some name",
    price: 42,
    rating: 120.5
  }
  @update_attrs %{
    category: [],
    location: "some updated location",
    minority: false,
    name: "some updated name",
    price: 43,
    rating: 456.7
  }
  @invalid_attrs %{
    category: nil,
    location: nil,
    minority: nil,
    name: nil,
    price: nil,
    rating: nil
  }

  def fixture(:business) do
    {:ok, business} = Community.create_business(@create_attrs)
    business
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    @tag :skip
    test "lists all businesses", %{conn: conn} do
      conn = get(conn, Routes.business_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create business" do
    @tag :skip
    test "renders business when data is valid", %{conn: conn} do
      conn = post(conn, Routes.business_path(conn, :create), business: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.business_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => [],
               "location" => "some location",
               "minority" => true,
               "name" => "some name",
               "price" => 42,
               "rating" => 120.5
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.business_path(conn, :create), business: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update business" do
    setup [:create_business]
    @tag :skip
    test "renders business when data is valid", %{
      conn: conn,
      business: %Business{id: id} = business
    } do
      conn = put(conn, Routes.business_path(conn, :update, business), business: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.business_path(conn, :show, id))

      assert %{
               "id" => id,
               "category" => [],
               "location" => "some updated location",
               "minority" => false,
               "name" => "some updated name",
               "price" => 43,
               "rating" => 456.7
             } = json_response(conn, 200)["data"]
    end

    @tag :skip
    test "renders errors when data is invalid", %{conn: conn, business: business} do
      conn = put(conn, Routes.business_path(conn, :update, business), business: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete business" do
    setup [:create_business]
    @tag :skip
    test "deletes chosen business", %{conn: conn, business: business} do
      conn = delete(conn, Routes.business_path(conn, :delete, business))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.business_path(conn, :show, business))
      end
    end
  end

  defp create_business(_) do
    business = fixture(:business)
    %{business: business}
  end
end
