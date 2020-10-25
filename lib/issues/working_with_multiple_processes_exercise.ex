defmodule Issues.WorkingWithMultipleProcessesExercise do
  @moduledoc """
  Write a program that spawns two processes and then passes each a
  unique token (for example, “fred” and “betty”). Have them send the
  tokens back.

  Q: Is the order in which the replies are received deterministic in
  theory? In practice?
  In theory I think it is not, in practice they tend to come back in the
  expected order

  Q: If either answer is no, how could you make it so?
  TODO, I don't know. Maybe move the call to the spawned process to the receive
  block so that a process is never called until the earlier message is received?

  """

  @doc """
  Issues.WorkingWithMultipleProcessesExercise.spawn_processes

  ## Parameters
     - number_of_processes_to_spawn

  Spawns n processes

  """
  @spec spawn_processes(pos_integer()) :: [pid()]
  def spawn_processes(number_of_processes_to_spawn) do
    create_process =  fn _n ->
      spawn(
        Issues.WorkingWithMultipleProcessesExercise,
        :send_token_back,
        []
      )
    end

    Enum.map(1..number_of_processes_to_spawn |> Enum.to_list(), create_process)
  end

  @doc """
  Issues.WorkingWithMultipleProcessesExercise.send_token_back

  Works as the receiver for processes spawned in spawn_processes/1

  """
  @spec send_token_back() :: any() # TODO, what does this return
  def send_token_back do
    receive do
      {:token, name, sender} ->
        send sender, {:token, name}
    end
  end

  @doc """
  Issues.WorkingWithMultipleProcessesExercise.send_token_to_processes

  ## Parameters
     - pid_list, list of pids to send tokens to

  Sends unique tokens to a list of spawned procesess, receives tokens back from
  those processes

  """
  @spec send_token_to_processes([pid()]) :: {:token, String.t()} | :all_messages_received
  def send_token_to_processes(pid_list) do
    Enum.map(pid_list, & send(&1, {:token, "Name#{System.unique_integer()}", self()}))

    receive do
      {:token, _name} ->
        send_token_to_processes([])
    # TODO, confirm the timeout is the key to allowing multiple messages to be
    # received while still being able to unit test. I believe it's required b/c
    # the process needs to stay alive to handle subsequent messages, but not
    # stay alive indefinitely after the last message is received as that causes
    # the test to wait and eventually time out.
    after 100 ->
      :all_messages_received
    end
  end

end
