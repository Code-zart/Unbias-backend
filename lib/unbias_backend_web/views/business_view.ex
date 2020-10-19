defmodule UnbiasBackendWeb.BusinessView do
  use UnbiasBackendWeb, :view
  alias UnbiasBackendWeb.BusinessView

  def render("index.json", %{businesses: businesses}) do
    %{data: render_many(businesses, BusinessView, "business.json")}
  end

  def render("show.json", %{business: business}) do
    %{data: render_one(business, BusinessView, "business.json")}
  end

  def render("business.json", %{business: business}) do
    %{id: business.id,
      name: business.name,
      location: business.location,
      minority: business.minority,
      category: business.category,
      rating: business.rating,
      price: business.price}
  end
end
