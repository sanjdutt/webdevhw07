defmodule Events.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :email, :string
    field :response, :string
    belongs_to :post, Events.Posts.Post
    belongs_to :user, Events.Users.User

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:email, :response, :post_id, :user_id])
    |> validate_required([:email, :response, :post_id, :user_id])
  end
end
