# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Backend.Repo.insert!(%Backend.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
# Dogs.create_breed(%{name: "Boxer", image: %{filename: "/images/breeds/boxer.jpg"}, description: "I once met one name Cassius Clay"})

Backend.Repo.insert!(%Backend.Dogs.Breed{name: "Boxer", description: "My friend had one named Cassius Clay", image: %Backend.Dogs.Image{filename: "/images/breeds/boxer.jpg"}})
Backend.Repo.insert!(%Backend.Dogs.Breed{name: "Border Collie", description: "Wasn't Lassie a Border Collie?", image: %Backend.Dogs.Image{filename: "/images/breeds/border_collie.jpg"}})
Backend.Repo.insert!(%Backend.Dogs.Breed{name: "Great Dane", description: "Overall, pretty great", image: %Backend.Dogs.Image{filename: "/images/breeds/great_dane.jpg"}})
