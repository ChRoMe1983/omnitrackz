defmodule OmnitracksWeb.WeightEntryLive.Show do
  use OmnitracksWeb, :live_view

  alias Omnitracks.Tracker

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:weight_entry, Tracker.get_weight_entry!(id))}
  end

  defp page_title(:show), do: "Show Weight entry"
  defp page_title(:edit), do: "Edit Weight entry"
end
