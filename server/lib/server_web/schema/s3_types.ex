defmodule ServerWeb.Schema.S3Types do
  use Absinthe.Schema.Notation

  alias ServerWeb.Resolvers

  object :s3_queries do
    @desc "Get s3 presigned url"
    field :s3_presigned_url, :s3_presigned_url_result do
      arg(:filename, non_null(:string))

      resolve(&Resolvers.S3.get_presigned_url/2)
    end
  end

  object :s3_presigned_url_result do
    field :url, :string
    field :fields, list_of(:s3_presigned_url_result_field)
  end

  object :s3_presigned_url_result_field do
    field :key, :string
    field :value, :string
  end
end
