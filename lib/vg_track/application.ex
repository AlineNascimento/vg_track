defmodule VgTrack.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      VgTrack.Repo,
      # Start the Telemetry supervisor
      VgTrackWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: VgTrack.PubSub},
      # Start the Endpoint (http/https)
      VgTrackWeb.Endpoint
      # Start a worker by calling: VgTrack.Worker.start_link(arg)
      # {VgTrack.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VgTrack.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VgTrackWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
