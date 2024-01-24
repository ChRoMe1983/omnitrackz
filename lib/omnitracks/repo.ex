defmodule Omnitracks.Repo do
  use Ecto.Repo,
    otp_app: :omnitracks,
    adapter: Ecto.Adapters.Postgres
end
