defmodule Issues.WorkingWithMultipleProcessesExerciseTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Issues.WorkingWithMultipleProcessesExercise, as: MultiProcessEx

  # trace/3 mentioned here: "https://medium.com/@hoodsuphopeshigh/testing-in-elixir-chapter-4-processes-processes-everywhere-f87ee3281bc"

  describe "spawn_processes/1" do
    property "spawns n processes" do
      # when runs > ~25, tests fail unexpectedly. Processes dieing or not
      # starting perhaps if n has too many large values?
      check all n <- positive_integer(), max_runs: 25 do
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

  @tag :pending
  test "send_token_to_process/2" do
   assert false
  end

  @tag :pending
  test "return_to_sender/1 sends token back to sender" do
    assert false
  end

end
