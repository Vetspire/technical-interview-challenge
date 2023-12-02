defprotocol Linnaeus.Model do
  @fallback_to_any true
  @spec all(t(), Keyword.t()) :: list(Ecto.Repo.Schema.t())
  def all(module, options)
end

defimpl Linnaeus.Model, for: Any do
  def all(module, options \\ [])

  def all(module, options) when is_atom(module) do
    module
    |> Linnaeus.Repo.all()
    |> Linnaeus.Repo.preload(Keyword.get(options, :preload, []))
  end

  def all(val, _options) do
    raise Linnaeus.Protocol.NotImplementedError.exception(
            for: @for,
            protocol: @protocol,
            value: val,
            arity: 2,
            function: :all
          )
  end
end
