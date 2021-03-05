defmodule Events.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :date, :map
    field :description, :string
    field :name, :string
    belongs_to :user, Events.Users.User

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :date, :description, :user_id])
    |> validate_required([:name, :date, :description, :user_id])
  end
end
