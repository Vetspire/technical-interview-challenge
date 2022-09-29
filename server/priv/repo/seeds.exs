alias VetspireChallenge.Upload

Path.wildcard("images/*")
|> Enum.map(fn path ->
  name = Path.basename(path) |> Path.rootname()
  ext = Path.extname(path)

  Upload.new_breed(name, path, ext)
end)
|> Enum.each(fn
  {:ok, breed} -> IO.puts("Inserted #{breed.name}")
  {:error, reason} -> IO.puts(reason)
end)
