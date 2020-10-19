defmodule UnbiasBackend.AccountTest do
  use UnbiasBackend.DataCase

  alias UnbiasBackend.Account

  describe "users" do
    alias UnbiasBackend.Account.User

    @valid_attrs %{age: 42, avatar: "some avatar", birthday: ~N[2010-04-17 14:00:00], email: "some email", favorites: [], gender: "some gender", location: "some location", name: "some name", password: "some password", race: [], token: "some token"}
    @update_attrs %{age: 43, avatar: "some updated avatar", birthday: ~N[2011-05-18 15:01:01], email: "some updated email", favorites: [], gender: "some updated gender", location: "some updated location", name: "some updated name", password: "some updated password", race: [], token: "some updated token"}
    @invalid_attrs %{age: nil, avatar: nil, birthday: nil, email: nil, favorites: nil, gender: nil, location: nil, name: nil, password: nil, race: nil, token: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Account.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Account.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Account.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Account.create_user(@valid_attrs)
      assert user.age == 42
      assert user.avatar == "some avatar"
      assert user.birthday == ~N[2010-04-17 14:00:00]
      assert user.email == "some email"
      assert user.favorites == []
      assert user.gender == "some gender"
      assert user.location == "some location"
      assert user.name == "some name"
      assert user.password == "some password"
      assert user.race == []
      assert user.token == "some token"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Account.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Account.update_user(user, @update_attrs)
      assert user.age == 43
      assert user.avatar == "some updated avatar"
      assert user.birthday == ~N[2011-05-18 15:01:01]
      assert user.email == "some updated email"
      assert user.favorites == []
      assert user.gender == "some updated gender"
      assert user.location == "some updated location"
      assert user.name == "some updated name"
      assert user.password == "some updated password"
      assert user.race == []
      assert user.token == "some updated token"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Account.update_user(user, @invalid_attrs)
      assert user == Account.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Account.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Account.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Account.change_user(user)
    end
  end
end
