defmodule UnbiasBackendWeb.UserView do
  use UnbiasBackendWeb, :view
  alias UnbiasBackendWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      age: user.age,
      name: user.name,
      birthday: user.birthday,
      location: user.location,
      favorites: user.favorites,
      race: user.race,
      gender: user.gender,
      email: user.email,
      password: user.password,
      token: user.token,
      avatar: user.avatar}
  end
end
