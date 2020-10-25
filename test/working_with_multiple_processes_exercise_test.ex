defmodule Issues.WorkingWithMultipleProcessesExerciseTest do
  use ExUnit.Case
  use ExUnitProperties

  alias Issues.WorkingWithMultipleProcessesExercise, as: MultiProcessEx

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

  describe "send_token_back/0" do
    setup do
      [pid_1, pid_2] = pid_list = MultiProcessEx.spawn_processes(2)

      {:ok, pid_1: pid_1, pid_2: pid_2, pid_list: pid_list}
    end

    test "sends token back to sender process",
      %{pid_1: pid_1, pid_2: pid_2, pid_list: pid_list} do

        :erlang.trace(pid_1, true, [:send])
        :erlang.trace(pid_2, true, [:send])
        MultiProcessEx.send_token_to_processes(pid_list)

        parent_process = self()
        assert_receive {:trace, ^pid_2, :send, {:token, some_token}, ^parent_process}
        assert_receive {:trace, ^pid_1, :send, {:token, some_other_token}, ^parent_process}
    end
  end

  describe "send_token_to_processes/1" do
    setup do
      [pid_1, pid_2] = pid_list = MultiProcessEx.spawn_processes(2)

      {:ok, pid_1: pid_1, pid_2: pid_2, pid_list: pid_list}
    end

    # TODO, how do I change this to test that parent process sends tokens to
    # spawned processes instead of testing the spawned processes receive
    # messages?
    test "receives unique tokens",
      %{pid_1: pid_1, pid_2: pid_2, pid_list: pid_list} do

        # trace/3 mentioned here:
        # "https://medium.com/@hoodsuphopeshigh/testing-in-elixir-chapter-4-processes-processes-everywhere-f87ee3281bc"
        :erlang.trace(pid_1, true, [:receive])
        :erlang.trace(pid_2, true, [:receive])

        MultiProcessEx.send_token_to_processes(pid_list)

        parent_process = self()
        assert_receive {:trace, ^pid_1, :receive, {:token, some_other_token, ^parent_process}}
        assert_receive {:trace, ^pid_2, :receive, {:token, some_token, ^parent_process}}

        assert some_token != some_other_token
    end
  end

end
