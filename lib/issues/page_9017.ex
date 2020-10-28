defmodule Issues.Page9017 do
  import :timer, only: [sleep: 1]
  @moduledoc """
  The Erlang function timer.sleep(time_in_ms) suspends the current
  process for a given time. You might want to use it to force some
  scenarios in the following exercises. The key with the exercises is to
  get used to the different reports you’ll see when you’re
  developing code.

  """

  @doc """
  Issues.Page9017.exercise_3

  Use spawn_link to start a process, and have that process send a
  message to the parent and then exit
  immediately. Meanwhile, sleep for 500 ms in the parent, then
  receive as many messages as are waiting. Trace what you
  receive.

  """
  @spec exercise_3 :: any()
  def exercise_3 do
  end

  @doc """
  Issues.Page9017.exercise_4

  Use spawn_link to start a process, and have that process send a
  message to the parent and then exit immediately. Meanwhile, sleep
  for 500 ms in the parent, then receive as many messages as are
  waiting. Trace what you receive.

  """
  @spec exercise_4 :: any()
  def exercise_4 do
  end

  @doc """
  Issues.Page9017.exercise_5

  Repeat the two, changing spawn_link to spawn_monitor

  """
  @spec exercise_5 :: any()
  def exercise_5 do
  end

end
