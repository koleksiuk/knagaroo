defmodule Knagaroo.Storage.MemoryTest do
  use ExUnit.Case

  alias Knagaroo.Storage.Memory, as: MemoryStorage

  setup do
    {:ok, storage} = MemoryStorage.start_link

    {:ok, storage: storage}
  end

  describe "get / set" do
    test "returns nil if value does not exist yet", %{storage: storage} do
      assert MemoryStorage.get(storage, "foo") == nil
    end

    test "returns value if value exists", %{storage: storage} do
      MemoryStorage.set(storage, "foo", "bar")
      assert MemoryStorage.get(storage, "foo") == {:ok, "bar"}
    end

    test "set returns ok if everything when ok", %{storage: storage} do
      assert MemoryStorage.set(storage, "foo", "bar") == :ok
    end

    test "set overrides existing value", %{storage: storage} do
      MemoryStorage.set(storage, "foo", "bar")
      MemoryStorage.set(storage, "foo", "baz")
      assert MemoryStorage.get(storage, "foo") == {:ok, "baz"}
    end
  end
end
