defmodule Linnaeus.Uploader do
  @moduledoc """
  Generic interface for accessing the uploader module in an environment.
  """

  @uploader :linnaeus
            |> Application.compile_env!(__MODULE__)
            |> Keyword.fetch!(:uploader_module)

  @callback upload(Plug.Upload.t()) :: {:ok, String.t()} | {:error, any()}

  @callback delete(String.t()) :: :ok | {:error, any()}

  def upload(%Plug.Upload{} = file) do
    @uploader.upload(file)
  end

  def delete(filename) do
    @uploader.delete(filename)
  end
end
