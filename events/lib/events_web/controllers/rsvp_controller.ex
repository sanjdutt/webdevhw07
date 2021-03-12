defmodule EventsWeb.RsvpController do
  use EventsWeb, :controller

  alias Events.Rsvps
  alias Events.Rsvps.Rsvp

  action_fallback EventsWeb.FallbackController

  def index(conn, _params) do
    rsvps = Rsvps.list_rsvps()
    render(conn, "index.json", rsvps: rsvps)
  end

  def create(conn, %{"rsvp" => rsvp_params}) do
    rsvp_params = rsvp_params
    |> Map.put("user_id", conn.assigns[:current_user].id)

    with {:ok, %Rsvp{} = rsvp} <- Rsvps.create_rsvp(rsvp_params) do
      rsvp = Rsvps.load_post(rsvp)

      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.rsvp_path(conn, :show, rsvp))
      |> render("show.json", rsvp: rsvp)
    end
  end

  def show(conn, %{"id" => id}) do
    rsvp = Rsvps.get_rsvp!(id)
    render(conn, "show.json", rsvp: rsvp)
  end

  def update(conn, %{"id" => id, "rsvp" => rsvp_params}) do
    rsvp = Rsvps.get_rsvp!(id)

    with {:ok, %Rsvp{} = rsvp} <- Rsvps.update_rsvp(rsvp, rsvp_params) do
      render(conn, "show.json", rsvp: rsvp)
    end
  end

  def delete(conn, %{"id" => id}) do
    rsvp = Rsvps.get_rsvp!(id)

    with {:ok, %Rsvp{}} <- Rsvps.delete_rsvp(rsvp) do
      send_resp(conn, :no_content, "")
    end
  end
end
