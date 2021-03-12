defmodule Events.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :date, :utc_datetime
    field :description, :string
    field :name, :string
    field :score, :integer, virtual: true
    belongs_to :user, Events.Users.User
    has_many :comments, Events.Comments.Comment
    has_many :rsvps, Events.Rsvps.Rsvp
    has_many :invites, Events.Invites.Invite
    

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :date, :description, :user_id])
    |> validate_required([:name, :date, :description, :user_id])
  end
end
