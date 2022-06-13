defmodule BackendWeb.Uploaders.TestUploader do
  @behaviour BackendWeb.Uploader

  def file_url(file_upload) do
    file_upload.filename
  end

  def upload(_src_file, _destination_file, _content_type) do
    {:ok, :test}
  end
end
