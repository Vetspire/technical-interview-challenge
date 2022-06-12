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

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Boxer",
  description: "My friend had one named Cassius Clay",
  image: %Backend.Dogs.Image{filename: "boxer.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Border Collie",
  description: "Wasn't Lassie a Border Collie?",
  image: %Backend.Dogs.Image{filename: "border_collie.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Great Dane",
  description: "Overall, pretty great",
  image: %Backend.Dogs.Image{filename: "great_dane.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Afenpinscher",
  description: "aka Monkey Terrier",
  image: %Backend.Dogs.Image{filename: "affenpinscher.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Cocker Spaniel",
  description: "Google says they make good family pets",
  image: %Backend.Dogs.Image{filename: "cocker_spaniel.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "English Bulldog",
  description: "Winston Churchill's favorite?",
  image: %Backend.Dogs.Image{filename: "english_bulldog.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Irish Terrier",
  description: "Originally from Ireland",
  image: %Backend.Dogs.Image{filename: "irish_terrier.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "norwich_terrier",
  description: "They are small",
  image: %Backend.Dogs.Image{filename: "affenpinscher.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Pomeranian",
  description: "Not the easiest to spell",
  image: %Backend.Dogs.Image{filename: "pomeranian.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Shetland Sheepdog",
  description: "The last one on the list!",
  image: %Backend.Dogs.Image{filename: "shetland_sheepdog.jpg"}
})
