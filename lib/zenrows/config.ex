defmodule ZenRows.Config do
  @moduledoc """
  Represents the configuration options for a ZenRows API request.

  The `ZenRows.Config` struct defines the available parameters that can be passed to the ZenRows API.
  These parameters allow customization of the scraping behavior and enable additional features.

  Refer to the [ZenRows API Documentation](https://docs.zenrows.com/api-reference) for more details on each parameter.

  ## Parameters

  - `js_render` (optional): Render the JavaScript on the page with a headless browser. Default is `false`. Enabling this option consumes 5 credits per request.
  - `premium_proxy` (optional): Use premium proxies to make the request harder to detect. Default is `false`. Enabling this option consumes 10-25 credits per request.
  - `proxy_country` (optional): Geolocation of the IP used to make the request. Only applicable when using premium proxies. Example: "us".
  - `session_id` (optional): Send a session ID number to use the same IP for each API request for up to 10 minutes.
  - `device` (optional): Use either desktop or mobile user agents in the headers. Default is `"desktop"`.
  - `original_status` (optional): Returns the status code provided by the website. Default is `false`.
  - `wait_for` (optional): Wait for a given CSS selector to load in the DOM before returning the content.
  - `wait` (optional): Wait a fixed amount of time (in milliseconds) before returning the content. Default is `0`.
  - `block_resources` (optional): Block specific resources from loading using this parameter.
  - `json_response` (optional): Get content in JSON format, including XHR or Fetch requests. Default is `false`.
  - `window_width` (optional): Set the browser's window width. Default is `1920`.
  - `window_height` (optional): Set the browser's window height. Default is `1080`.
  - `css_extractor` (optional): Define CSS selectors to extract data from the HTML. Expects a JSON string.
  - `autoparse` (optional): Use the auto-parser algorithm to automatically extract data. Default is `false`.
  - `return_screenshot` (optional): Return a full-page screenshot of the target page. Default is `false`.
  - `resolve_captcha` (optional): Use a CAPTCHA solver integration to automatically solve interactive CAPTCHAs in the page. Default is `false`.

  ### Proxy countries

  List of some available countries and their code, you can check out the whole list on the [builder](https://app.zenrows.com/builder).

  - United States: us
  - Canada: ca
  - United Kingdom: gb
  - Germany: de
  - France: fr
  - Spain: es
  - Brazil: br
  - Mexico: mx
  - India: in
  - Japan: jp
  - China: cn
  """
  @type t :: %__MODULE__{
          js_render: boolean() | nil,
          premium_proxy: boolean() | nil,
          proxy_country: binary() | nil,
          session_id: integer() | nil,
          device: :desktop | :mobile | nil,
          original_status: boolean() | nil,
          wait_for: binary() | nil,
          wait: pos_integer() | nil,
          block_resources: binary() | nil,
          json_response: boolean() | nil,
          window_width: integer() | nil,
          window_height: integer() | nil,
          css_extractor: map() | nil,
          autoparse: boolean() | nil,
          return_screenshot: boolean() | nil,
          resolve_captcha: boolean() | nil
        }

  defstruct [
    :js_render,
    :premium_proxy,
    :proxy_country,
    :session_id,
    :device,
    :original_status,
    :wait_for,
    :wait,
    :block_resources,
    :json_response,
    :window_width,
    :window_height,
    :css_extractor,
    :autoparse,
    :return_screenshot,
    :resolve_captcha
  ]
end
