defmodule QueueTest do
  use ExUnit.Case

  alias Queue

  test "start_link/1" do
    params = [1, 2, 3, 4]

    {response, _pid} = Queue.start_link(params)

    assert :ok = response
  end

  test "current/1" do
    params = [1, 2, 3, 4]

    {:ok, pid} = Queue.start_link(params)

    response = Queue.current(pid)

    assert params  == response
  end

  test "enqueue/2" do
    params = [1, 2, 3, 4]

    {:ok, pid} = Queue.start_link(params)

    element = 7

    response = Queue.enqueue(pid, element)

    new_state = [element] ++ params

    assert :ok = response
    assert new_state  == Queue.current(pid)
  end

  test "dequeue/1" do
    params = [1, 2, 3, 4]

    {:ok, pid} = Queue.start_link(params)

    response = Queue.dequeue(pid)

    [head | tail] = params

    assert head = response
    assert tail  == Queue.current(pid)
  end
end
