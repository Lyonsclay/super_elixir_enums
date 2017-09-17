defmodule SuperEnumsTest do
  use ExUnit.Case
  # doctest SuperEnums
  defmodule FunCase do

    import SuperEnums
    make :targetOne, [:one, :two, :three]

    def getTarget do
      enums :targetOne, [[one: 1], [two: 2]]
    end
  end

  test "make" do
    [h|t] = FunCase.getTarget
    assert Enum.find(Map.keys(h), fn key -> key end) == :__struct__
    assert h == %TargetOne{one: 1, two: nil, three: nil}
  end
end
