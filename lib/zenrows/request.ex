defmodule ZenRows.Request do
  @moduledoc false
  alias ZenRows.Config

  @api_url "https://api.zenrows.com/v1"
  @version Application.spec(:zenrows, :vsn)

  @doc """
  Sends a GET request to the specified URL with the given options.
  """
  @spec get(String.t(), ZenRows.options()) :: {:ok, Req.Response.t()} | {:error, Exception.t()}
  def get(url, opts \\ []) do
    case validate_opts(opts) do
      {:ok, opts} ->
        Req.get(@api_url, params(url, opts))

      {:error, error} ->
        {:error, error}
    end
  end

  @doc """
  Sends a POST request to the specified URL with the given options.
  """
  @spec post(String.t(), ZenRows.options()) :: {:ok, Req.Response.t()} | {:error, Exception.t()}
  def post(url, opts \\ []) do
    case validate_opts(opts) do
      {:ok, opts} ->
        Req.post(@api_url, params(url, opts))

      {:error, error} ->
        {:error, error}
    end
  end

  defp params(url, opts) do
    headers = Keyword.get(opts, :headers, [])

    query =
      opts[:config]
      |> Map.from_struct()
      |> Map.drop(drop_keys(opts[:config]))
      |> Map.merge(%{url: url, apikey: api_key()})
      |> maybe_put_custom_headers(headers)

    [
      params: query,
      headers: [{"user-agent", "zenrows/#{@version} elixir"} | headers],
      receive_timeout: opts[:timeout],
      retry: :transient,
      max_retries: opts[:retries]
    ]
    |> maybe_put_data(opts)
  end

  defp drop_keys(config) do
    config
    |> Map.from_struct()
    |> Enum.filter(fn {_, v} -> is_nil(v) end)
    |> Enum.map(fn {k, _} -> k end)
  end

  @spec validate_opts(ZenRows.options()) :: {:ok, ZenRows.options()} | {:error, String.t()}
  defp validate_opts(opts) do
    config = Keyword.get(opts, :config, %Config{})

    if Config.requires_javascript?(config) && !config.js_render do
      {:error, "Requires js"}
    else
      {:ok, opts}
    end
  end

  @spec maybe_put_custom_headers(map(), list()) :: map()
  defp maybe_put_custom_headers(query, headers) do
    if length(headers) > 0 do
      Map.put(query, :custom_headers, true)
    else
      query
    end
  end

  @spec maybe_put_data(keyword(), keyword()) :: keyword()
  defp maybe_put_data(params, opts) do
    case Keyword.get(opts, :data) do
      nil -> params
      %{} = data -> Keyword.put(params, :json, data)
      data -> Keyword.put(params, :body, data)
    end
  end

  defp api_key, do: Application.get_env(:zenrows, :api_key)
end
