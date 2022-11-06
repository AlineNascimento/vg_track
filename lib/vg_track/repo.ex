defmodule VgTrack.Repo do
  use Ecto.Repo,
    otp_app: :vg_track,
    adapter: Ecto.Adapters.Postgres
end
