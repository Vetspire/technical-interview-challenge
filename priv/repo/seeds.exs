# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     VetspireTakeHome.Repo.insert!(%VetspireTakeHome.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias VetspireTakeHome.Repo

now = NaiveDateTime.local_now()

Repo.insert_all(VetspireTakeHome.Breeds.Breed, [
  %{
    id: 1,
    name: "Affen Pinscher",
    image_url: "/assets/images/affenpinscher.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 2,
    name: "Border Collie",
    image_url: "/assets/images/border_collie.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 3,
    name: "Boxer",
    image_url: "/assets/images/boxer.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 4,
    name: "Cocker Spaniel",
    image_url: "/assets/images/cocker_spaniel.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 5,
    name: "English Bulldog",
    image_url: "/assets/images/english_bulldog.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 6,
    name: "Great Dane",
    image_url: "/assets/images/great_dane.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 7,
    name: "Irish Terrier",
    image_url: "/assets/images/irish_terrier.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 8,
    name: "Norwich Terrier",
    image_url: "/assets/images/norwich_terrier.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 9,
    name: "Pomeranian",
    image_url: "/assets/images/pomeranian.jpg",
    inserted_at: now,
    updated_at: now
  },
  %{
    id: 10,
    name: "Shetland Sheepdog",
    image_url: "/assets/images/shetland_sheepdog.jpg",
    inserted_at: now,
    updated_at: now
  }
])
