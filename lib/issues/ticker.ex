defmodule Issues.Ticker do

  @name     :ticker

  def start do
    pid = spawn(__MODULE__, :generator, [[]])
    :global.register_name(@name, pid)
  end

  def register(client_pid) do
    send :global.whereis_name(@name), { :register, client_pid }
  end

  def generator(clients) do
    receive do
      { :register, pid } ->
        IO.puts "registering #{inspect pid}"
        all_clients = [pid|clients]
        case all_clients do
          [_pid] ->
            generator(all_clients)
          [p1, p2] ->
            send p1, { :next, p2 }
            send p2, { :next, p1 }

            send p1, { :tick }
            generator(all_clients)
          [h1, h2 | t] ->
            send h1, { :next, List.last(t) }
            send h2, { :next, h1 }
            generator(all_clients)
        end
    end
  end
end

defmodule Issues.Client do
  import :timer, only: [sleep: 1]

  @interval 2000   # 2 seconds

  def start() do
    pid = spawn(__MODULE__, :receiver, [])
    Issues.Ticker.register(pid)
  end

  def receiver(next_pid \\ nil) do
    receive do
      { :tick } ->
        IO.puts "tock\nMessage received at #{inspect self()}"

        sleep @interval
        send next_pid, { :tick }

        receiver(next_pid)
      { :next, pid } ->
        receiver(pid)
    end
  end
end
