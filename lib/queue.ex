defmodule Queue do
  use GenServer

  # Client
  def start_link(initial_stack) do
    GenServer.start_link(__MODULE__, initial_stack)
  end

  def enqueue(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def dequeue(pid) do
    GenServer.call(pid, :pop)
  end

  def current(pid) do
    GenServer.call(pid, :current)
  end


  # Server
  @impl true
  def init(stack) do
    {:ok, stack}
  end

  @impl true
  def handle_cast({:push, element}, stack) do
    new_stack = [element | stack]

    {:noreply, new_stack}
  end

  @impl true
  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  @impl true
  def handle_call(:current, _from, stack) do
    {:reply, stack, stack}
  end
end
