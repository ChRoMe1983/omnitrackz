defmodule OmnitracksWeb.WeightEntryLiveTest do
  use OmnitracksWeb.ConnCase

  import Phoenix.LiveViewTest
  import Omnitracks.TrackerFixtures

  @create_attrs %{date: "2024-01-23", weight: 120.5}
  @update_attrs %{date: "2024-01-24", weight: 456.7}
  @invalid_attrs %{date: nil, weight: nil}

  defp create_weight_entry(_) do
    weight_entry = weight_entry_fixture()
    %{weight_entry: weight_entry}
  end

  describe "Index" do
    setup [:create_weight_entry]

    test "lists all weight_entries", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/weight_entries")

      assert html =~ "Listing Weight entries"
    end

    test "saves new weight_entry", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/weight_entries")

      assert index_live |> element("a", "New Weight entry") |> render_click() =~
               "New Weight entry"

      assert_patch(index_live, ~p"/weight_entries/new")

      assert index_live
             |> form("#weight_entry-form", weight_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#weight_entry-form", weight_entry: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/weight_entries")

      html = render(index_live)
      assert html =~ "Weight entry created successfully"
    end

    test "updates weight_entry in listing", %{conn: conn, weight_entry: weight_entry} do
      {:ok, index_live, _html} = live(conn, ~p"/weight_entries")

      assert index_live |> element("#weight_entries-#{weight_entry.id} a", "Edit") |> render_click() =~
               "Edit Weight entry"

      assert_patch(index_live, ~p"/weight_entries/#{weight_entry}/edit")

      assert index_live
             |> form("#weight_entry-form", weight_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#weight_entry-form", weight_entry: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/weight_entries")

      html = render(index_live)
      assert html =~ "Weight entry updated successfully"
    end

    test "deletes weight_entry in listing", %{conn: conn, weight_entry: weight_entry} do
      {:ok, index_live, _html} = live(conn, ~p"/weight_entries")

      assert index_live |> element("#weight_entries-#{weight_entry.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#weight_entries-#{weight_entry.id}")
    end
  end

  describe "Show" do
    setup [:create_weight_entry]

    test "displays weight_entry", %{conn: conn, weight_entry: weight_entry} do
      {:ok, _show_live, html} = live(conn, ~p"/weight_entries/#{weight_entry}")

      assert html =~ "Show Weight entry"
    end

    test "updates weight_entry within modal", %{conn: conn, weight_entry: weight_entry} do
      {:ok, show_live, _html} = live(conn, ~p"/weight_entries/#{weight_entry}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Weight entry"

      assert_patch(show_live, ~p"/weight_entries/#{weight_entry}/show/edit")

      assert show_live
             |> form("#weight_entry-form", weight_entry: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#weight_entry-form", weight_entry: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/weight_entries/#{weight_entry}")

      html = render(show_live)
      assert html =~ "Weight entry updated successfully"
    end
  end
end
