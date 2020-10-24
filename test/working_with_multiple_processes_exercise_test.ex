defmodule Issues.WorkingWithMultipleProcessesExerciseTest do
  use ExUnit.Case
  alias Issues.WorkingWithMultipleProcessesExercise, as: MultiProcessEx

  # trace/3 mentioned here: "https://medium.com/@hoodsuphopeshigh/testing-in-elixir-chapter-4-processes-processes-everywhere-f87ee3281bc"

  test "spawn_two_processes/1" do
    process_count_before =
      Process.list()
      |> Enum.count()

    MultiProcessEx.spawn_two_processes()

    process_count_after =
      Process.list()
      |> Enum.count()

    assert process_count_before + 2 == process_count_after
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
