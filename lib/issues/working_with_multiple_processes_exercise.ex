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
     -n Positive Integer, represents how many processes you'd like to spawn

  Spawns n processes
  """
  @spec spawn_processes(pos_integer()) :: [pid()]
  def spawn_processes(number_of_processes_to_spawn) do
    parent = self()
    create_process =  fn _n ->
      spawn fn -> send(parent, {:ok, "Person#{System.unique_integer()}"}) end
    end

    Enum.each(1..number_of_processes_to_spawn, create_process)
  end


  @doc """
  Spawns two processes, sending each one a unique token. The processes then send
  their tokens back
  """
  def run do

  end

end
