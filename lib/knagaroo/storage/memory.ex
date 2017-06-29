defmodule Knagaroo.Storage.Memory do
  use GenServer
  #
  # === Public API
  @doc """
    Starts Memory storage
  """
  @spec start_link() :: pid
  def start_link() do
    GenServer.start_link(__MODULE__, [], [])
  end

  @doc """
    Lookups storage for given key
  """
  @spec get(pid, String.t) :: nil
  @spec get(pid, String.t) :: {:ok, String.t}
  def get(storage_pid, key) do
    GenServer.call(storage_pid, {:get, key})
  end

  @doc """
    Binds given key in a storage to a value
  """
  @spec set(pid, String.t, String.t) :: {:ok, String.t}
  def set(storage_pid, key, value) do
    GenServer.call(storage_pid, {:set, key, value})
  end

  # === Private API
  def init([]) do
    {:ok, Map.new}
  end

  def handle_call({:get, key}, _from, state) do
    resp = case Map.fetch(state, key) do
      :error -> nil
      {:ok, value} -> {:ok, value}
    end
    {:reply, resp, state}
  end

  def handle_call({:set, key, value}, _from, state) do
    {:reply, {:ok, key}, Map.put(state, key, value)}
  end
end
