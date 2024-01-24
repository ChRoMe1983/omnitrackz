defmodule Omnitracks.TrackerFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Omnitracks.Tracker` context.
  """

  @doc """
  Generate a weight_entry.
  """
  def weight_entry_fixture(attrs \\ %{}) do
    {:ok, weight_entry} =
      attrs
      |> Enum.into(%{
        date: ~D[2024-01-23],
        weight: 120.5
      })
      |> Omnitracks.Tracker.create_weight_entry()

    weight_entry
  end
end
