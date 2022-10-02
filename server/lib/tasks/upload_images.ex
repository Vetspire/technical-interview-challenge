defmodule Mix.Tasks.UploadImages do
  @moduledoc """
  Upload images to cloud storage
  """

  use Mix.Task

  alias Server.S3

  @requirements ["app.config", "app.start"]

  @impl Mix.Task
  def run(_args) do
    image_paths = Path.wildcard("priv/repo/images/**")

    for image_path <- image_paths do
      file_content = File.read!(image_path)
      filename = Path.basename(image_path)
      s3_path = S3.get_s3_path("dog", filename)

      result = S3.upload(file_content, s3_path)

      case result do
        {:ok, %{status_code: 200}} ->
          IO.inspect("Successfully upload filename: #{filename}")

        {:error, error} ->
          IO.inspect("Failed to upload filename: #{filename} with error: #{inspect(error)}")
      end
    end
  end
end
