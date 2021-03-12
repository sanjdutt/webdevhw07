defmodule Events.Repo.Migrations.CreateRsvps do
  use Ecto.Migration

  def change do
    create table(:rsvps) do
      add :rsvps, :integer, null: false
      add :post_id, references(:posts, on_delete: :nothing), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:rsvps, [:post_id, :user_id], unique: true)
    create index(:rsvps, [:post_id])
    create index(:rsvps, [:user_id])
  end
end
