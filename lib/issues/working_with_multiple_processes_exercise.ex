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
  Spawns two processes
  """
  @spec spawn_two_processes :: [pid()]
  def spawn_two_processes do
    parent = self()
    pid_1 = spawn fn ->
      send(parent, {:world, self()})
    end
    pid_2 = spawn fn ->
      send(parent, {:world, self()})
    end
  end


  @doc """
  Spawns two processes, sending each one a unique token. The processes then send
  their tokens back
  """
  def run do

  end

end
