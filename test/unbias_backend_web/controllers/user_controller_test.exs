defmodule UnbiasBackendWeb.UserControllerTest do
  use UnbiasBackendWeb.ConnCase

  alias UnbiasBackend.Account
  alias UnbiasBackend.Account.User

  @create_attrs %{
    age: 42,
    avatar: "some avatar",
    birthday: ~N[2010-04-17 14:00:00],
    email: "some email",
    favorites: [],
    gender: "some gender",
    location: "some location",
    name: "some name",
    password: "some password",
    race: [],
    token: "some token"
  }
  @update_attrs %{
    age: 43,
    avatar: "some updated avatar",
    birthday: ~N[2011-05-18 15:01:01],
    email: "some updated email",
    favorites: [],
    gender: "some updated gender",
    location: "some updated location",
    name: "some updated name",
    password: "some updated password",
    race: [],
    token: "some updated token"
  }
  @invalid_attrs %{age: nil, avatar: nil, birthday: nil, email: nil, favorites: nil, gender: nil, location: nil, name: nil, password: nil, race: nil, token: nil}

  def fixture(:user) do
    {:ok, user} = Account.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 42,
               "avatar" => "some avatar",
               "birthday" => "2010-04-17T14:00:00",
               "email" => "some email",
               "favorites" => [],
               "gender" => "some gender",
               "location" => "some location",
               "name" => "some name",
               "password" => "some password",
               "race" => [],
               "token" => "some token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => id,
               "age" => 43,
               "avatar" => "some updated avatar",
               "birthday" => "2011-05-18T15:01:01",
               "email" => "some updated email",
               "favorites" => [],
               "gender" => "some updated gender",
               "location" => "some updated location",
               "name" => "some updated name",
               "password" => "some updated password",
               "race" => [],
               "token" => "some updated token"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = fixture(:user)
    %{user: user}
  end
end
