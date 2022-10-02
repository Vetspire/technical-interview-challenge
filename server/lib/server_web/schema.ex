defmodule ServerWeb.Schema do
  use Absinthe.Schema

  import_types(ServerWeb.Schema.PetTypes)
  import_types(ServerWeb.Schema.S3Types)

  query do
    import_fields(:pet_queries)
    import_fields(:s3_queries)
  end
end
