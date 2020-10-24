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

  # mix test.watch test/working_with_multiple_processes_exercise_test.ex
  describe "send_token_to_process/1" do
    setup do
      [pid_1, pid_2] = pid_list = MultiProcessEx.spawn_processes(2)

      {:ok, pid_1: pid_1, pid_2: pid_2, pid_list: pid_list}
    end

    test "sends tokens to processes",
      %{pid_1: pid_1, pid_2: pid_2, pid_list: pid_list} do

        :erlang.trace(pid_1, true, [:receive])
        :erlang.trace(pid_2, true, [:receive])

        MultiProcessEx.send_token_to_process(pid_list)

        assert_receive {:trace, ^pid_1, :receive, {:token, "Name-" <> uniq_char}}
        assert_receive {:trace, ^pid_2, :receive, {:token, "Name-" <> uniq_char}}
    end

    test "tokens are unique",
      %{pid_list: pid_list} do

        tokens = MultiProcessEx.send_token_to_process(pid_list)
        get_token_value = fn token -> elem(token, 1) end

        assert tokens == Enum.uniq_by(tokens, get_token_value)
    end
  end

  @tag :pending
  test "return_to_sender/1 sends token back to sender" do
    assert false
  end

end
