defmodule Issues.WorkingWithMultipleProcessesExerciseTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Issues.WorkingWithMultipleProcessesExercise, as: MultiProcessEx

  # trace/3 mentioned here: "https://medium.com/@hoodsuphopeshigh/testing-in-elixir-chapter-4-processes-processes-everywhere-f87ee3281bc"

  describe "spawn_processes/1" do
    property "spawns n processes" do
      # when runs > ~20, tests fail unexpectedly. Processes dieing or not
      # starting perhaps if n has too many large values?
      check all n <- positive_integer(), max_runs: 20 do
        process_count_before =
          Process.list()
          |> Enum.count()

        MultiProcessEx.spawn_processes(n)

        process_count_after =
          Process.list()
          |> Enum.count()

        assert process_count_before + n == process_count_after
      end
    end
  end

  describe "send_token_to_process/2" do
    test "sends message to process" do
      [pid_1, pid_2] = MultiProcessEx.spawn_processes(2)
      assert_receive {:token, ^pid_1, "fred"}
      assert_receive {:token, ^pid_2, "betty"}
    end
  end

  @tag :pending
  test "return_to_sender/1 sends token back to sender" do
    assert false
  end

end
