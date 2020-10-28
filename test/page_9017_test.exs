defmodule Issues.Page9017Test do
  use ExUnit.Case
  use ExUnitProperties

  alias Issues.Page9017

  describe "exercise_3/0" do
    test "it receives a message from a process which is not alive" do
      Page9017.exercise_3()
      assert_receive {:hello, "world"}
    end
  end

  describe "exercise_4/0" do
    setup do
    end

    @tag :pending
    test "" do
    end
  end

  describe "exercise_5/0" do
    setup do
    end

    @tag :pending
    test "" do
    end
  end

end
