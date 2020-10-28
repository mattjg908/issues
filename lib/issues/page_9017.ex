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
    parent = self()
    fn ->
      spawn_link fn -> send(parent, {:hello, "world"}) end
    end
    |> run()
  end

  @doc """
  Issues.Page9017.exercise_4

  Do the same as in exercise_3 but raise an exception instead.

  """
  @spec exercise_4 :: any()
  def exercise_4 do
    fn ->
      spawn_link fn -> raise "Some exception message" end
    end
    |> run()
  end

  @doc """
  Issues.Page9017.exercise_5a

  Repeat the exercise_3, changing spawn_link to spawn_monitor

  """
  @spec exercise_5a :: any()
  def exercise_5a do
    parent = self()
    fn ->
      spawn_monitor fn -> send(parent, {:hello, "world"}) end
    end
    |> run()
  end

  @doc """
  Issues.Page9017.exercise_5b

  Repeat the exercise_4, changing spawn_link to spawn_monitor

  """
  @spec exercise_5b :: any()
  def exercise_5b do
    fn ->
      spawn_monitor fn -> raise "Some exception message" end
    end
    |> run()
  end

  @spec run(fun()) :: any()
  defp run(spawn_link_func) do
    spawn_link_func.()

    sleep 500

    receive_message()
  end

  defp receive_message do
    receive do
      msg ->
        IO.inspect msg
    after 1000 ->
        IO.puts "Waited 1 second and didn't receive any messages"
    end
  end

end
