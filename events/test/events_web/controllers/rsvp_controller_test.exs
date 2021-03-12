defmodule EventsWeb.RsvpControllerTest do
  use EventsWeb.ConnCase

  alias Events.Rsvps
  alias Events.Rsvps.Rsvp

  @create_attrs %{
    rsvps: 42
  }
  @update_attrs %{
    rsvps: 43
  }
  @invalid_attrs %{rsvps: nil}

  def fixture(:rsvp) do
    {:ok, rsvp} = Rsvps.create_rsvp(@create_attrs)
    rsvp
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all rsvps", %{conn: conn} do
      conn = get(conn, Routes.rsvp_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create rsvp" do
    test "renders rsvp when data is valid", %{conn: conn} do
      conn = post(conn, Routes.rsvp_path(conn, :create), rsvp: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.rsvp_path(conn, :show, id))

      assert %{
               "id" => id,
               "rsvps" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.rsvp_path(conn, :create), rsvp: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update rsvp" do
    setup [:create_rsvp]

    test "renders rsvp when data is valid", %{conn: conn, rsvp: %Rsvp{id: id} = rsvp} do
      conn = put(conn, Routes.rsvp_path(conn, :update, rsvp), rsvp: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.rsvp_path(conn, :show, id))

      assert %{
               "id" => id,
               "rsvps" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, rsvp: rsvp} do
      conn = put(conn, Routes.rsvp_path(conn, :update, rsvp), rsvp: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete rsvp" do
    setup [:create_rsvp]

    test "deletes chosen rsvp", %{conn: conn, rsvp: rsvp} do
      conn = delete(conn, Routes.rsvp_path(conn, :delete, rsvp))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.rsvp_path(conn, :show, rsvp))
      end
    end
  end

  defp create_rsvp(_) do
    rsvp = fixture(:rsvp)
    %{rsvp: rsvp}
  end
end
