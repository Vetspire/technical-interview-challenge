defmodule Linnaeus.Protocol.NotImplementedError do
  defexception [
    :arity,
    :for,
    :function,
    :protocol,
    :value
  ]

  def message(%__MODULE__{
        arity: arity,
        function: func,
        for: for_,
        protocol: protocol,
        value: value
      }) do
    error =
      Protocol.UndefinedError.exception(
        protocol: protocol,
        value: value,
        description: "#{protocol}.#{func}/#{arity} is not implemented for #{for_}"
      )

    error.message
  end
end
