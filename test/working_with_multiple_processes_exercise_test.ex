defmodule WorkingWithMultipleProcessesExerciseTest do
  use ExUnit.Case          # bring in the test functionality
  alias WorkingWithMultipleProcessesExercise, as: MultiProcessEx


  describe "run/0" do
    # TODO, how to test that a function spawns two functions? What I have is not
    # really testing that
    test "spawns two processes" do
      [process1, process2] = MultiProcessEx.run()
      assert is_process(process1) && is_process(process2)
    end

    test "sends both processes a unique token" do
      [process1, process2] = MultiProcessEx.run()
      # trace/3 mentioned here:
      # "https://medium.com/@hoodsuphopeshigh/testing-in-elixir-chapter-4-processes-processes-everywhere-f87ee3281bc"
      :erlang.trace(process1, true [:receive])
      :erlang.trace(process2, true [:receive])
      assert_received {:trace, ^process1, :receive, "fred"}
      assert_received {:trace, ^process2, :receive, "betty"}
    end

    # TODO, how to test a process sends a message? I have only seen assertions
    # for receiving so this test also doesn't really test what I want
    test "both processes send the token back" do
      MultiProcessEx.run()
      assert_receive "fred"
      assert_receive "betty"
    end
  end

end
