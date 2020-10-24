defmodule Issues.WorkingWithMultipleProcessesExercise do
  @moduledoc """
  Write a program that spawns two processes and then passes each a
  unique token (for example, “fred” and “betty”). Have them send the
  tokens back.

  Is the order in which the replies are received deterministic in
  theory? In practice?

  If either answer is no, how could you make it so?

  """

  @doc """
  Issues.WorkingWithMultipleProcessesExercise.spawn_processes

  ## Parameters
     - number_of_processes_to_spawn

  Spawns n processes

  """
  @spec spawn_processes(pos_integer()) :: [pid()]
  def spawn_processes(number_of_processes_to_spawn) do
    parent = self()
    create_process =  fn _n ->
      spawn fn ->
        receive do
          {:token, token} -> token
        end
      end
    end

    Enum.map(1..number_of_processes_to_spawn, create_process)
  end

  @doc """
  Issues.WorkingWithMultipleProcessesExercise.send_token_to_process

  ## Parameters
     - pid_list, list of pids to send tokens to

  Sends unique tokens to spawned procesess

  """
  @spec send_token_to_process([pid()]) :: [{:token, String.t()}]
  def send_token_to_process([p1, _p2] = pid_list),
    do: Enum.map(pid_list, & send(&1, {:token, "Name#{System.unique_integer()}"}))

end
