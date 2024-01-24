defmodule Omnitracks.Tracker do
  @moduledoc """
  The Tracker context.
  """

  import Ecto.Query, warn: false
  alias Omnitracks.Repo

  alias Omnitracks.Tracker.WeightEntry

  @doc """
  Returns the list of weight_entries.

  ## Examples

      iex> list_weight_entries()
      [%WeightEntry{}, ...]

  """
  def list_weight_entries do
    Repo.all(WeightEntry)
  end

  @doc """
  Gets a single weight_entry.

  Raises `Ecto.NoResultsError` if the Weight entry does not exist.

  ## Examples

      iex> get_weight_entry!(123)
      %WeightEntry{}

      iex> get_weight_entry!(456)
      ** (Ecto.NoResultsError)

  """
  def get_weight_entry!(id), do: Repo.get!(WeightEntry, id)

  @doc """
  Creates a weight_entry.

  ## Examples

      iex> create_weight_entry(%{field: value})
      {:ok, %WeightEntry{}}

      iex> create_weight_entry(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_weight_entry(attrs \\ %{}) do
    %WeightEntry{}
    |> WeightEntry.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a weight_entry.

  ## Examples

      iex> update_weight_entry(weight_entry, %{field: new_value})
      {:ok, %WeightEntry{}}

      iex> update_weight_entry(weight_entry, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_weight_entry(%WeightEntry{} = weight_entry, attrs) do
    weight_entry
    |> WeightEntry.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a weight_entry.

  ## Examples

      iex> delete_weight_entry(weight_entry)
      {:ok, %WeightEntry{}}

      iex> delete_weight_entry(weight_entry)
      {:error, %Ecto.Changeset{}}

  """
  def delete_weight_entry(%WeightEntry{} = weight_entry) do
    Repo.delete(weight_entry)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking weight_entry changes.

  ## Examples

      iex> change_weight_entry(weight_entry)
      %Ecto.Changeset{data: %WeightEntry{}}

  """
  def change_weight_entry(%WeightEntry{} = weight_entry, attrs \\ %{}) do
    WeightEntry.changeset(weight_entry, attrs)
  end
end
