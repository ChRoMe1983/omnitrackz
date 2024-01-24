defmodule OmnitracksWeb.WeightEntryController do
  use OmnitracksWeb, :controller

  alias Omnitracks.Repo
  alias Omnitracks.WeightEntry
##  alias Omnitracks.Accounts.User

  # Funktion, um das Formular für einen neuen Gewichtseintrag zu rendern
  def new(conn, _params) do
    changeset = WeightEntry.changeset(%WeightEntry{}, %{})
    render(conn, "new.html", changeset: changeset)
  end

  # Funktion, um einen neuen Gewichtseintrag zu erstellen
  def create(conn, %{"weight_entry" => weight_entry_params}) do
    # Annahme: Sie haben eine Möglichkeit, den aktuellen Benutzer zu identifizieren
    user = conn.assigns[:current_user]

    # Verknüpfen des Benutzer-IDs mit dem Gewichtseintrag
    weight_entry_params_with_user = Map.put(weight_entry_params, "user_id", user.id)

    changeset = WeightEntry.changeset(%WeightEntry{}, weight_entry_params_with_user)

    case Repo.insert(changeset) do
      {:ok, _weight_entry} ->
        # Erfolg: Weiterleitung und Erfolgsmeldung
        conn
        |> put_flash(:info, "Weight entry created successfully.")
        |> redirect(to: "/path_to_redirect") # Pfad anpassen
      {:error, changeset} ->
        # Fehler: Formular mit Fehlermeldungen erneut rendern
        render(conn, "new.html", changeset: changeset)
    end
  end
end
