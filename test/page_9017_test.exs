defmodule Issues.Page9017Test do
  use ExUnit.Case
  use ExUnitProperties

  import ExUnit.CaptureIO

  alias Issues.Page9017

  describe "exercise_3/0" do
    @tag :pending
    test "it receives a message from a process which already exited" do
      receive_msg_output = fn ->
        Page9017.exercise_3()
      end

      assert capture_io(receive_msg_output) == "{:hello, \"world\"}\n"
    end
  end

  describe "exercise_4/0" do

    test "it communicates to the parent that an exception was raised" do
      Process.flag(:trap_exit, true)
      pid = spawn_link(fn ->  Page9017.exercise_4() end)
      assert_receive {
        :EXIT,
        ^pid,
        {
          %RuntimeError{message: "Some exception message"}, _other_file_info
        }
      }
    end
  end

  describe "exercise_5/0" do
    setup do
    end

    @tag :pending
    test "" do
    end
  end

end
