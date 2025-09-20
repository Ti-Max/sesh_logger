defmodule SeshLogger.Repo do
  use Ecto.Repo,
    otp_app: :sesh_logger,
    adapter: Ecto.Adapters.Postgres
end
