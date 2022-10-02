defmodule ServerWeb.Resolvers.S3 do
  @moduledoc """
  The S3 Resolver context
  """

  alias Server.S3

  require Logger

  def get_presigned_url(args, _resolution) do
    %{filename: filename} = args
    expires_in_one_hour = 60 * 60
    opts = [expires_in: expires_in_one_hour]
    s3_path = S3.get_s3_path("dog", filename)

    s3_presigned_url_result = s3().presigned_post(s3_path, opts)

    fields =
      Enum.map(
        s3_presigned_url_result.fields,
        fn {key, value} -> %{key: key, value: value} end
      )

    s3_presigned_url_result = %{s3_presigned_url_result | fields: fields}

    {:ok, s3_presigned_url_result}
  end

  defp s3, do: Application.get_env(:server, :s3, Server.S3)
end
