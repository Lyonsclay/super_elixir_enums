defmodule SuperEnums do
  @moduledoc """
  Documentation for SuperEnums.
  """

  @doc """
  Defines a struct of all the fields a set of values can have.
  Takes an atom as the enum type name and a list of all possible
  fields a node can have.

  ## Examples

      iex> SuperEnums.make :work_days, [:mon, :tues, :wed, :thurs, :fri]

      iex> SuperEnums.make :hello_world, [:hello, world: "one big place"]
      %HelloWorld{hello: nil, world: "one big place"}

  """
  # @spec make(atom()|non_neg_integer()|binary(), list(integer())) -> {ok, boolean()} | {exit, atom()}
  defmacro make(type, fields) do
    quote do
      defmodule Name.module(unquote(type)) do
        defstruct unquote(fields)
      end
    end
  end

  defmacro enums(type, nodes) do
    quote do
      Enum.map unquote(nodes), fn node -> struct Name.module(unquote(type)), node end

    end
  end

  def _has_nodes list do
    list |>
      Enum.any?(fn l -> Kernel.is_list l end)
  end
end

defmodule Name do
  def module(name) do
    name
    |> Atom.to_string
    |> Macro.camelize
    |> String.to_atom
    |> List.wrap
    |> Module.concat
  end
end
