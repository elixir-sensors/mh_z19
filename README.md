# MhZ19 [![hex.pm version](https://img.shields.io/hexpm/v/mh_z19.svg)](https://hex.pm/packages/mh_z19)

A Elixir library to measure CO2 concentration value from MH-Z19 sensor.

## Usage

```elixir
iex> {:ok, pid} = MhZ19.start_link
{:ok, #PID<0.1104.0>}
iex> {:ok, result} = MhZ19.measure(pid)
{:ok,
 %MhZ19.Measurement{
   co2_concentration: 650
 }}
```

## References

* [Intelligent Infrared CO2 Module (Model: MH-Z19) User’s Manual (Version: 1.0)](https://www.winsen-sensor.com/d/files/PDF/Infrared%20Gas%20Sensor/NDIR%20CO2%20SENSOR/MH-Z19%20CO2%20Ver1.0.pdf)
* [Elixir × Nerves で MH-Z19 を動かす](https://qiita.com/katshun0307/items/4abb2d4d8e96c0ab1015) (in Japanese)
* [mh-z19 · PyPI](https://pypi.org/project/mh-z19/)
