defmodule Server.DogFactory do
  alias Server.Pets.Dog

  defmacro __using__(_opts) do
    quote do
      def dog_factory(attrs) do
        breed = Map.get(attrs, :title, "cavapoo")

        description =
          Map.get(
            attrs,
            :title,
            "The Cavapoo, sometimes known as a Cavoodle, is a cross between a Poodle and a Cavalier King Charles Spaniel. They have become increasingly popular pets over the years due to their playfulness, affectionate nature and low tendency to shed."
          )

        image_url = Map.get(attrs, :title, "https://placedog.net/500")

        dog = %Dog{
          breed: breed,
          description: description,
          image_url: image_url
        }

        dog
        |> merge_attributes(attrs)
        |> evaluate_lazy_attributes()
      end
    end
  end
end
