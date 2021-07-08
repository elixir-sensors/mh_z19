defmodule MhZ19 do
  @moduledoc File.read!("./README.md") |> String.replace(~r/^# .+\n\n/, "")

  use GenServer
  alias Circuits.UART

  @commands [
    co2_concentration: <<0xFF, 0x01, 0x86, 0x00, 0x00, 0x00, 0x00, 0x00, 0x79>>
  ]

  @doc """
  Initializes a GenServer process with given `opts`.

  ## Options

  - `:tty` - (String) Set the name of the serial device. Defaults to `ttyAMA0`.
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

  @doc """
  Starts a GenServer process with given `opts`.

  ## Options

  - `:name` - (Atom) Set the name of the GenServer process. Defaults to `MhZ19`.

  ## Examples

  ```elixir
  iex> {:ok, pid} = MhZ19.start_link
  ```
  """
  def start_link(opts \\ []) do
    name = opts[:name] || __MODULE__
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  @doc """
  Retrieves the current CO2 concentration value.

  ## Examples

  ```elixir
  iex> {:ok, result} = MhZ19.measure(pid)
  {:ok, %{co2_concentration: 650}}
  ```
  """
  def measure(pid) do
    GenServer.call(pid, :measure)
  end

  @impl GenServer
  def handle_call(:measure, _from, state) do
    {:reply, retrieve_co2_concentration(state), state}
  end

  defp retrieve_co2_concentration(state) do
    :ok = UART.write(state.uart, @commands[:co2_concentration])

    UART.read(state.uart)
    |> handle_data(state)
  end

  defp handle_data({:ok, <<0xFF, 0x86, high, low, _, _, _, _>>}, _state) do
    data = high * 256 + low
    {:ok, %{co2_concentration: data}}
  end

  defp handle_data({:error, reason}, _state) do
    {:error, reason}
  end

  defp handle_data({:ok, <<>>}, _state) do
    {:error, :timeout}
  end

  defp handle_data(_, state) do
    retrieve_co2_concentration(state)
  end
end
