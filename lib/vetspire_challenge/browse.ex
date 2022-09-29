defmodule VetspireChallenge.Browse do
  import Ecto.Query

  alias VetspireChallenge.Schemas.Breed
  alias VetspireChallenge.Repo

  def list_breeds(options \\ %{}) do
    %{sort: sort, limit: limit, offset: offset} = get_pagination_args(options)
    order_by = [{sort, :name}] |> IO.inspect()

    from(breed in Breed)
    |> order_by(^order_by)
    |> limit(^limit)
    |> offset(^offset)
    |> Repo.all()
  end

  defp get_pagination_args(options) do
    sort = Map.get(options, :sort, "asc") |> String.downcase() |> normalize_sort()
    limit = Map.get(options, :limit, 100) |> normalize_limit()
    offset = Map.get(options, :offset, 0) |> normalize_offset()

    %{sort: sort, limit: limit, offset: offset}
  end

  defp normalize_sort(sort) when sort in ["asc", "desc"], do: String.to_existing_atom(sort)
  defp normalize_sort(_), do: :asc

  defp normalize_limit(limit) when limit > 0, do: limit
  defp normalize_limit(_), do: 100

  defp normalize_offset(offset) when offset >= 0, do: offset
  defp normalize_offset(_), do: 0
end
