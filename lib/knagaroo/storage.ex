defmodule Knagaroo.Storage do
  @spec start_link(atom, list) :: pid
  def start_link(module, args) do
    GenServer.start_link(module, args, [])
  end

  @spec get(pid, String.t) :: nil
  @spec get(pid, String.t) :: {:ok, String.t}
  def get(storage_pid, key) do
    GenServer.call(storage_pid, {:get, key})
  end

  @spec set(pid, String.t, String.t) :: {:ok, String.t}
  def set(storage_pid, key, value) do
    GenServer.call(storage_pid, {:set, key, value})
  end
end
