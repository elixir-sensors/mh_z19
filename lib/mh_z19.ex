defmodule MhZ19 do
  @moduledoc """
  Documentation for `MhZ19`.
  """

  use GenServer
  alias Circuits.UART

  @commands [
    co2_concentration: <<0xFF, 0x01, 0x86, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79>>
  ]

  @doc """
  Hello world.

  ## Examples

      iex> MhZ19.hello()
      :world

  """
  @impl GenServer
  def init(opts \\ []) do
    {:ok, uart} = UART.start_link()

    :ok =
      UART.open(uart, opts[:tty] || "ttyAMA0",
        speed: 9_600,
        data_bits: 8,
        stop_bits: 1,
        parity: :none,
        active: false
      )

    {:ok, %{uart: uart}}
  end

  def start_link(opts \\ []) do
    name = opts[:name] || __MODULE__
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  def measure(pid) do
    GenServer.call(pid, :measure)
  end

  @impl GenServer
  def handle_call(:measure, _from, state) do
    {:reply, read_co2_concentration(state), state}
  end

  defp read_co2_concentration(state) do
    :ok = UART.write(state.uart, @commands[:co2_concentration])

    UART.read(state.uart)
    |> handle_data(state)
  end

  defp handle_data({:ok, <<0xFF, 0x86, high, low, _, _, _, _>>}, state) do
    data = high * 256 + low
    {:reply, {:ok, data}, state}
  end

  defp handle_data({:error, reason}, state) do
    {:reply, {:error, reason}, state}
  end

  defp handle_data({:ok, <<>>}, state) do
    {:reply, {:error, :timeout}, state}
  end

  defp handle_data(_, state) do
    read_co2_concentration(state)
  end
end
