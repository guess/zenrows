defmodule ZenRows do
  @moduledoc """
  A client library for interacting with the ZenRows API.

  The `ZenRows` module provides a simple and convenient way to send HTTP requests to the ZenRows API.
  It supports both GET and POST requests and allows customization of request options.

  ## Configuration

  The `ZenRows` module can be configured using the application environment. The following options are available:

  - `:api_key` (required): The API key for authentication with the ZenRows API.
  - `:adapter` (optional): The HTTP adapter module to use for requests. Default is `Tesla.Adapter.Hackney`.
  - `:retries` (optional): The number of times to retry failed requests. Default is 0.
  - `:delay` (optional): The initial delay in milliseconds between retries. Default is 500.
  - `:max_delay` (optional): The maximum delay in milliseconds between retries. Default is 4000.

  Example configuration:

      config :zenrows,
        api_key: "YOUR_API_KEY",
        adapter: Tesla.Adapter.Mint,
        retries: 3,
        delay: 1000,
        max_delay: 10_000

  ## Usage

  To make a GET request:

      ZenRows.get("https://example.com", headers: %{"Authorization" => "Bearer token"}, config: %ZenRows.Config{js_render: true})

  To make a POST request:

      ZenRows.post("https://example.com", data: %{key: "value"}, headers: %{"Authorization" => "Bearer token"})

  ## Options

  The following options can be passed to `get/2` and `post/2`:

  - `:headers` (optional): A map of additional headers to include in the request. Default is an empty map.
  - `:config` (optional): A `ZenRows.Config` struct specifying the configuration options for the request. Default is an empty struct.
  - `:data` (optional): A map of data to be sent as the request body in a POST request. Default is an empty map.
  - `:adapter` (optional): The HTTP adapter module to use for the request. Default is `Tesla.Adapter.Hackney`.
  - `:retries` (optional): The number of times to retry failed requests. Overrides the application environment configuration.
  - `:delay` (optional): The initial delay in milliseconds between retries. Overrides the application environment configuration.
  - `:max_delay` (optional): The maximum delay in milliseconds between retries. Overrides the application environment configuration.
  """

  alias ZenRows.{Config, Request}

  @type options :: [option()]
  @type option ::
          {:headers, map()}
          | {:config, Config.t()}
          | {:data, map()}
          | {:adapter, module()}
          | {:retries, non_neg_integer()}
          | {:delay, non_neg_integer()}
          | {:max_delay, non_neg_integer()}

  @doc """
  Sends a GET request to the specified URL with the given options.

  Returns a `Tesla.Env` struct representing the response.
  """
  @spec get(String.t(), options()) :: Tesla.Env.result()
  def get(url, opts \\ []) do
    opts = NimbleOptions.validate!(opts, schema())
    Request.get(url, opts)
  end

  @doc """
  Sends a POST request to the specified URL with the given options.

  Returns a `Tesla.Env` struct representing the response.
  """
  @spec post(String.t(), options()) :: Tesla.Env.result()
  def post(url, opts \\ []) do
    opts = NimbleOptions.validate!(opts, schema())
    Request.post(url, opts)
  end

  defp schema do
    [
      headers: [
        type: {:map, :string, :string},
        default: %{}
      ],
      config: [
        type: {:struct, Config},
        default: %Config{}
      ],
      data: [
        type: {:map, {:or, [:string, :atom]}, :any},
        default: %{}
      ],
      retries: [
        type: :non_neg_integer,
        default: Application.get_env(:zenrows, :retries, 0)
      ],
      delay: [
        type: :non_neg_integer,
        default: Application.get_env(:zenrows, :delay, 500)
      ],
      max_delay: [
        type: :non_neg_integer,
        default: Application.get_env(:zenrows, :max_delay, 4_000)
      ]
    ]
  end
end
