defmodule ZenRows.Request do
  @moduledoc false
  @api_url "https://api.zenrows.com/v1"
  @version Application.spec(:zenrows, :vsn)

  @middleware [
    {Tesla.Middleware.BaseUrl, @api_url},
    {Tesla.Middleware.Timeout, timeout: 30_000},
    {Tesla.Middleware.Headers, [{"user-agent", "zenrows/#{@version} elixir"}]},
    Tesla.Middleware.JSON,
    Tesla.Middleware.Logger
  ]

  @doc """
  Sends a GET request to the specified URL with the given options.
  """
  @spec get(String.t(), ZenRows.options()) :: Tesla.Env.result()
  def get(url, opts \\ []) do
    Tesla.get(client(opts), "/", params(url, opts))
  end

  @doc """
  Sends a POST request to the specified URL with the given options.
  """
  @spec post(String.t(), ZenRows.options()) :: Tesla.Env.result()
  def post(url, opts \\ []) do
    Tesla.post(client(opts), "/", opts[:data], params(url, opts))
  end

  defp params(url, opts) do
    headers = Enum.into(opts[:headers], [])

    query =
      opts[:config]
      |> Map.from_struct()
      |> Map.drop(drop_keys(opts[:config]))
      |> Map.merge(%{url: url, apikey: api_key()})
      |> maybe_put_custom_headers(headers)

    [query: query, headers: headers, opts: [adapter: [recv_timeout: 30_000]]]
  end

  defp drop_keys(config) do
    config
    |> Map.from_struct()
    |> Enum.filter(fn {_, v} -> is_nil(v) end)
    |> Enum.map(fn {k, _} -> k end)
  end

  defp maybe_put_custom_headers(params, headers) do
    if length(headers) > 0 do
      Map.put(params, :custom_headers, true)
    else
      params
    end
  end

  defp client(opts) do
    middleware =
      [
        {
          Tesla.Middleware.Retry,
          delay: opts[:delay],
          max_retries: opts[:retries],
          max_delay: opts[:max_delay],
          should_retry: &should_retry/1
        },
        {
          Tesla.Middleware.Timeout,
          timeout: opts[:timeout]
        }
      ] ++ @middleware

    Tesla.client(middleware, opts[:adapter] || default_adapter())
  end

  defp should_retry({:ok, %{status: status}}) when status == 429, do: true
  defp should_retry({:ok, _}), do: false
  defp should_retry({:error, _}), do: true

  defp api_key, do: Application.get_env(:zenrows, :api_key)

  defp default_adapter, do: Application.get_env(:zenrows, :adapter, Tesla.Adapter.Hackney)
end
