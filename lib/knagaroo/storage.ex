defmodule Knagaroo.Storage do
  # === Public API
  @doc """
    Starts Memory storage
  """
  @spec start_link(atom, list) :: pid
  def start_link(module, args) do
    GenServer.start_link(module, args, [])
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
end
