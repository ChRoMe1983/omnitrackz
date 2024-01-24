defmodule OmnitracksWeb.WeightEntryLive.Index do
  use OmnitracksWeb, :live_view

  alias Omnitracks.Tracker
  alias Omnitracks.Tracker.WeightEntry

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :weight_entries, Tracker.list_weight_entries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Weight entry")
    |> assign(:weight_entry, Tracker.get_weight_entry!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Weight entry")
    |> assign(:weight_entry, %WeightEntry{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Weight entries")
    |> assign(:weight_entry, nil)
  end

  @impl true
  def handle_info({OmnitracksWeb.WeightEntryLive.FormComponent, {:saved, weight_entry}}, socket) do
    {:noreply, stream_insert(socket, :weight_entries, weight_entry)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    weight_entry = Tracker.get_weight_entry!(id)
    {:ok, _} = Tracker.delete_weight_entry(weight_entry)

    {:noreply, stream_delete(socket, :weight_entries, weight_entry)}
  end
end
