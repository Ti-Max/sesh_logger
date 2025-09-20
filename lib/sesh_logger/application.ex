defmodule SeshLogger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SeshLoggerWeb.Telemetry,
      SeshLogger.Repo,
      {DNSCluster, query: Application.get_env(:sesh_logger, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SeshLogger.PubSub},
      # Start a worker by calling: SeshLogger.Worker.start_link(arg)
      # {SeshLogger.Worker, arg},
      # Start to serve requests, typically the last entry
      SeshLoggerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SeshLogger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SeshLoggerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
