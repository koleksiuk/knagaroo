defmodule Knagaroo.ClientTest do
  use ExUnit.Case

  alias Knagaroo.Client
  alias Knagaroo.Storage.Memory

  setup do
    {:ok, client} = Client.start_link(Memory)

    {:ok, client: client}
  end

  test "handles get operation on unknown key", %{client: client} do
    assert Client.handle_operation(client, {:get, "foo"}) == nil
  end

  test "handles set operation", %{client: client} do
    assert Client.handle_operation(client, {:set, "foo", "bar"}) == :ok
  end

  test "handles get operation on known key", %{client: client} do
    assert Client.handle_operation(client, {:get, "foo"}) == nil
    assert Client.handle_operation(client, {:set, "foo", "bar"}) == :ok
    assert Client.handle_operation(client, {:get, "foo"}) == "bar"
  end
end
