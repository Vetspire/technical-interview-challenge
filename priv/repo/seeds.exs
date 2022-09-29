alias VetspireChallenge.Schemas.Breed
alias VetspireChallenge.Repo

breeds =
  Path.wildcard("images/*")
  |> Enum.map(&Path.basename/1)
  |> Enum.map(&%{name: Path.rootname(&1) |> Base.decode32!(), image: &1})

Repo.insert_all(Breed, breeds, on_conflict: :nothing, conflict_target: [:name])
