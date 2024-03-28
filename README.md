# Zenrows

ZenRows is an Elixir client library for interacting with the [ZenRows API](https://docs.zenrows.com/api-reference). It provides a simple and convenient way to send HTTP requests to the ZenRows API, allowing you to scrape web pages and extract data easily.

## Installation

Add zenrows to your list of dependencies in mix.exs:

```elixir
def deps do
  [
    {:zenrows, "~> 0.1.0"}
  ]
end
```

Then run `mix deps.get` to install the dependency.

## Configuration

Configure the zenrows library by adding the following to your `config.exs` file:

```elixir
config :zenrows,
  api_key: "YOUR_API_KEY",
  adapter: Tesla.Adapter.Hackney,
  retries: 3,
  delay: 1000,
  max_delay: 10_000
```

- `api_key` (required): Your ZenRows API key. Get your free API key from the ZenRows dashboard.
- `adapter` (optional): The HTTP adapter module to use for requests. Default is `Tesla.Adapter.Hackney`.
- `retries` (optional): The number of times to retry failed requests. Default is 0.
- `delay` (optional): The initial delay in milliseconds between retries. Default is 500.
- `max_delay` (optional): The maximum delay in milliseconds between retries. Default is 4000.

## Usage

### Making GET requests

```elixir
ZenRows.get("https://example.com", headers: %{"Authorization" => "Bearer token"}, config: %ZenRows.Config{js_render: true})
```

### Making POST requests

```elixir
ZenRows.post("https://example.com", data: %{key: "value"}, headers: %{"Authorization" => "Bearer token"})
```

## Request Options

- `:headers` (optional): A map of additional headers to include in the request. Default is an empty map.
- `:config` (optional): A ZenRows.Config struct specifying the configuration options for the request. Default is an empty struct.
- `:data` (optional): A map of data to be sent as the request body in a POST request. Default is an empty map.
- `:adapter` (optional): The HTTP adapter module to use for the request. Default is Tesla.Adapter.Hackney.
- `:retries` (optional): The number of times to retry failed requests. Overrides the application environment configuration.
- `:delay` (optional): The initial delay in milliseconds between retries. Overrides the application environment configuration.
- `:max_delay` (optional): The maximum delay in milliseconds between retries. Overrides the application environment configuration.

For more information on the available configuration options, refer to the `ZenRows.Config` documentation.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or submit a pull request on the GitHub repository.

## License

ZenRows is released under the MIT License. See the [LICENSE](LICENSE) file for more information.
