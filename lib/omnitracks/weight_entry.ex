defmodule Omnitracks.WeightEntry do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weight_entries" do
    belongs_to :user, Omnitracks.Accounts.User
    field :date, :date
    field :weight, :float
    timestamps()
  end

  @doc false
  def changeset(weight_entry, attrs) do
    weight_entry
    |> cast(attrs, [:user_id, :date, :weight])
    |> validate_required([:user_id, :date, :weight])
  end
end
