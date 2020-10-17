defmodule UnbiasBackend.Repo do
  use Ecto.Repo,
    otp_app: :unbias_backend,
    adapter: Ecto.Adapters.Postgres
end
