defmodule EventsWeb.RsvpView do
  use EventsWeb, :view
  alias EventsWeb.RsvpView

  def render("index.json", %{rsvps: rsvps}) do
    %{data: render_many(rsvps, RsvpView, "rsvp.json")}
  end

  def render("show.json", %{rsvp: rsvp}) do
    %{data: render_one(rsvp, RsvpView, "rsvp.json")}
  end

  def render("rsvp.json", %{rsvp: rsvp}) do
   post = EventsWeb.PostView.render_json(rsvp.post)
    %{id: rsvp.id,
      rsvps: rsvp.rsvps,
      post: post,
     }
  end
end
