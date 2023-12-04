defmodule LinnaeusWeb.Plug.FileUploader do
  @moduledoc """
  Plug that handles uploaded files and saves them somewhere.
  """

  require Logger
  alias Plug.Conn

  @behaviour Plug

  def init([]) do
    []
  end

  def call(%Conn{params: %{"image_file" => %Plug.Upload{} = file}} = conn, _opts) do
    case Linnaeus.Uploader.upload(file) do
      {:ok, asset_url} ->
        Conn.assign(conn, :asset_url, asset_url)

      {:error, error} ->
        Logger.warning(message: "Error uploading file to CDN", error: error)
        conn
    end
  end

  def call(%Conn{path_info: ["api", "v1", "breeds", _], method: "POST"} = conn, _opts) do
    Logger.warning(message: "unexpected params", params: conn.params)

    conn
  end

  def call(%Conn{} = conn, _opts) do
    conn
  end
end
