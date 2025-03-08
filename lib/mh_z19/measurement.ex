# SPDX-FileCopyrightText: 2021 Kentaro Kuribayashi
#
# SPDX-License-Identifier: Apache-2.0
#
defmodule MhZ19.Measurement do
  @moduledoc """
  One sensor measurement report
  """

  defstruct [
    :co2_concentration
  ]

  @type t :: %__MODULE__{
          co2_concentration: number
        }
end
