defmodule OmnitracksWeb.WeightEntryLive.FormComponent do
  use OmnitracksWeb, :live_component

  alias Omnitracks.Tracker

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage weight_entry records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="weight_entry-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:date]} type="date" label="Date" />
        <.input field={@form[:weight]} type="number" label="Weight" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Weight entry</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{weight_entry: weight_entry} = assigns, socket) do
    changeset = Tracker.change_weight_entry(weight_entry)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"weight_entry" => weight_entry_params}, socket) do
    changeset =
      socket.assigns.weight_entry
      |> Tracker.change_weight_entry(weight_entry_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"weight_entry" => weight_entry_params}, socket) do
    save_weight_entry(socket, socket.assigns.action, weight_entry_params)
  end

  defp save_weight_entry(socket, :edit, weight_entry_params) do
    case Tracker.update_weight_entry(socket.assigns.weight_entry, weight_entry_params) do
      {:ok, weight_entry} ->
        notify_parent({:saved, weight_entry})

        {:noreply,
         socket
         |> put_flash(:info, "Weight entry updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_weight_entry(socket, :new, weight_entry_params) do
    case Tracker.create_weight_entry(weight_entry_params) do
      {:ok, weight_entry} ->
        notify_parent({:saved, weight_entry})

        {:noreply,
         socket
         |> put_flash(:info, "Weight entry created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
