defmodule ServerWeb.Schema do
  use Absinthe.Schema

  import_types(ServerWeb.Schema.PetTypes)

  query do
    import_fields(:pet_queries)
  end
end
