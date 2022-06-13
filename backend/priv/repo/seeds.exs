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
  image: %Backend.FileUpload{filename: "boxer.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Border Collie",
  description: "Wasn't Lassie a Border Collie?",
  image: %Backend.FileUpload{filename: "border_collie.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Great Dane",
  description: "Overall, pretty great",
  image: %Backend.FileUpload{filename: "great_dane.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Afenpinscher",
  description: "aka Monkey Terrier",
  image: %Backend.FileUpload{filename: "affenpinscher.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Cocker Spaniel",
  description: "Google says they make good family pets",
  image: %Backend.FileUpload{filename: "cocker_spaniel.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "English Bulldog",
  description: "Winston Churchill's favorite?",
  image: %Backend.FileUpload{filename: "english_bulldog.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Irish Terrier",
  description: "Originally from Ireland",
  image: %Backend.FileUpload{filename: "irish_terrier.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "norwich_terrier",
  description: "They are small",
  image: %Backend.FileUpload{filename: "affenpinscher.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Pomeranian",
  description: "Not the easiest to spell",
  image: %Backend.FileUpload{filename: "pomeranian.jpg"}
})

Backend.Repo.insert!(%Backend.Dogs.Breed{
  name: "Shetland Sheepdog",
  description: "The last one on the list!",
  image: %Backend.FileUpload{filename: "shetland_sheepdog.jpg"}
})
