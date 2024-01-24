defmodule Omnitracks.Tracker.WeightEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weight_entries" do
    field :date, :date
    field :weight, :float
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(weight_entry, attrs) do
    weight_entry
    |> cast(attrs, [:date, :weight])
    |> validate_required([:date, :weight])
  end
end
