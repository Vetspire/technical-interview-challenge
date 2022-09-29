alias VetspireChallenge.{Breed, Repo}

breeds =
  Path.wildcard("images/*")
  |> Enum.map(&Path.basename/1)
  |> Enum.map(&Path.rootname/1)
  |> Enum.map(&%{name: Base.decode32!(&1), image: &1})

Repo.insert_all(Breed, breeds, on_conflict: :nothing, conflict_target: [:name])
