defmodule Hella.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HellaWeb.Telemetry,
      # Start the Ecto repository
      Hella.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Hella.PubSub},
      # Start Finch
      {Finch, name: Hella.Finch},
      # Start the Endpoint (http/https)
      HellaWeb.Endpoint
      # Start a worker by calling: Hella.Worker.start_link(arg)
      # {Hella.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Hella.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HellaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
