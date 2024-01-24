defmodule Omnitracks.TrackerTest do
  use Omnitracks.DataCase

  alias Omnitracks.Tracker

  describe "weight_entries" do
    alias Omnitracks.Tracker.WeightEntry

    import Omnitracks.TrackerFixtures

    @invalid_attrs %{date: nil, weight: nil}

    test "list_weight_entries/0 returns all weight_entries" do
      weight_entry = weight_entry_fixture()
      assert Tracker.list_weight_entries() == [weight_entry]
    end

    test "get_weight_entry!/1 returns the weight_entry with given id" do
      weight_entry = weight_entry_fixture()
      assert Tracker.get_weight_entry!(weight_entry.id) == weight_entry
    end

    test "create_weight_entry/1 with valid data creates a weight_entry" do
      valid_attrs = %{date: ~D[2024-01-23], weight: 120.5}

      assert {:ok, %WeightEntry{} = weight_entry} = Tracker.create_weight_entry(valid_attrs)
      assert weight_entry.date == ~D[2024-01-23]
      assert weight_entry.weight == 120.5
    end

    test "create_weight_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Tracker.create_weight_entry(@invalid_attrs)
    end

    test "update_weight_entry/2 with valid data updates the weight_entry" do
      weight_entry = weight_entry_fixture()
      update_attrs = %{date: ~D[2024-01-24], weight: 456.7}

      assert {:ok, %WeightEntry{} = weight_entry} = Tracker.update_weight_entry(weight_entry, update_attrs)
      assert weight_entry.date == ~D[2024-01-24]
      assert weight_entry.weight == 456.7
    end

    test "update_weight_entry/2 with invalid data returns error changeset" do
      weight_entry = weight_entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Tracker.update_weight_entry(weight_entry, @invalid_attrs)
      assert weight_entry == Tracker.get_weight_entry!(weight_entry.id)
    end

    test "delete_weight_entry/1 deletes the weight_entry" do
      weight_entry = weight_entry_fixture()
      assert {:ok, %WeightEntry{}} = Tracker.delete_weight_entry(weight_entry)
      assert_raise Ecto.NoResultsError, fn -> Tracker.get_weight_entry!(weight_entry.id) end
    end

    test "change_weight_entry/1 returns a weight_entry changeset" do
      weight_entry = weight_entry_fixture()
      assert %Ecto.Changeset{} = Tracker.change_weight_entry(weight_entry)
    end
  end
end
