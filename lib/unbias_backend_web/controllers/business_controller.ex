defmodule UnbiasBackendWeb.BusinessController do
  use UnbiasBackendWeb, :controller

  alias UnbiasBackend.Community
  alias UnbiasBackend.Community.Business

  action_fallback UnbiasBackendWeb.FallbackController

  def index(conn, _params) do
    businesses = Community.list_businesses()
    render(conn, "index.json", businesses: businesses)
  end

  def create(conn, %{"business" => business_params}) do
    with {:ok, %Business{} = business} <- Community.create_business(business_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.business_path(conn, :show, business))
      |> render("show.json", business: business)
    end
  end

  def show(conn, %{"id" => id}) do
    business = Community.get_business!(id)
    render(conn, "show.json", business: business)
  end

  def update(conn, %{"id" => id, "business" => business_params}) do
    business = Community.get_business!(id)

    with {:ok, %Business{} = business} <- Community.update_business(business, business_params) do
      render(conn, "show.json", business: business)
    end
  end

  def delete(conn, %{"id" => id}) do
    business = Community.get_business!(id)

    with {:ok, %Business{}} <- Community.delete_business(business) do
      send_resp(conn, :no_content, "")
    end
  end
end
