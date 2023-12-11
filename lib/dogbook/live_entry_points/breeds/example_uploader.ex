defmodule Dogbook.LiveEntryPoints.Breeds.ExampleUploader do
  @behaviour Phoenix.LiveView.UploadWriter

  @impl true
  def init(opts) do
    file_name = "/uploads/breeds/example_images/#{opts.entry.uuid}"

    # ExAws is frankly gross. Not much we're going to do to solve that today.
    upload_op =
      with init_op <- ExAws.S3.initiate_multipart_upload("dogbook", file_name, %{}),
           {:ok, %{body: %{upload_id: upload_id}}} <-
             ExAws.request(init_op, ExAws.Config.new(:s3)) do
        Map.merge(init_op, %{upload_id: upload_id, opts: %{max_concurrency: 3}})
      end

    {:ok,
     %{
       file_name: file_name,
       chunk: 1,
       s3_operation: upload_op,
       s3_config: ExAws.Config.new(upload_op.service),
       parts: []
     }}
  end

  @impl true
  def meta(state) do
    %{file_name: state.file_name}
  end

  @impl true
  def write_chunk(data, state) do
    part = ExAws.S3.Upload.upload_chunk!({data, state.chunk}, state.s3_operation, state.s3_config)
    {:ok, Map.merge(state, %{chunk: state.chunk + 1, parts: [part | state.parts]})}
  end

  @impl true
  def close(state, _reason) do
    case ExAws.S3.Upload.complete(state.parts, state.s3_operation, state.s3_config) do
      {:ok, _} -> {:ok, state}
      {:error, reason} -> {:error, reason}
    end
  end
end
