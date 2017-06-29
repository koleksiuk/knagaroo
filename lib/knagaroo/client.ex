defmodule Knagaroo.Client do
  use GenServer

  alias Knagaroo.Storage

  # === Public API
  @spec start_link(atom, list) :: pid
  def start_link(storage_module, storage_args \\ []) do
    GenServer.start_link(__MODULE__, {storage_module, storage_args}, [])
  end

  @spec handle_operation(pid, {:get, String.t}) :: nil
  @spec handle_operation(pid, {:get, String.t}) :: String.t
  def handle_operation(pid, {:get, key}) do
    GenServer.call(pid, {:get, key})
  end

  @spec handle_operation(pid, {:set, String.t, String.t}) :: :ok
  def handle_operation(pid, {:set, key, value}) do
    GenServer.cast(pid, {:set, key, value})
  end

  # === Private API
  def init({storage_module, storage_args}) do
    send(self(), {:initialize_storage, storage_module, storage_args})

    {:ok, nil}
  end

  def handle_call({:get, key}, _from, storage_pid) do
    val = case Storage.get(storage_pid, key) do
      {:ok, value} -> value
      nil -> nil
    end

    {:reply, val, storage_pid}
  end

  def handle_cast({:set, key, value}, storage_pid) do
    {:ok, _key} = Storage.set(storage_pid, key, value)

    {:noreply, storage_pid}
  end

  def handle_info({:initialize_storage, module, args}, _state) do
    {:ok, storage_pid} = Storage.start_link(module, args)

    {:noreply, storage_pid}
  end
end
