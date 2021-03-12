defmodule Events.Rsvps.Rsvp do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rsvps" do
    field :rsvps, :integer
  # field :post_id, :id
  # field :user_id, :id
    belongs_to :post, Events.Posts.Post
    belongs_to :user, Events.Users.User

    timestamps()
  end

  @doc false
  def changeset(rsvp, attrs) do
    rsvp
    |> cast(attrs, [:rsvps, :user_id, :post_id])
    |> validate_required([:rsvps, :user_id, :post_id])
  end
end
