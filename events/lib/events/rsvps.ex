defmodule Events.Rsvps do
  @moduledoc """
  The Rsvps context.
  """

  import Ecto.Query, warn: false
  alias Events.Repo

  alias Events.Rsvps.Rsvp

  @doc """
  Returns the list of rsvps.
  ## Examples
      iex> list_rsvps()
      [%Rsvp{}, ...]
  """
  def list_rsvps do
    Repo.all(Rsvp)
  end

  @doc """
  Gets a single rsvp.
  Raises `Ecto.NoResultsError` if the Rsvp does not exist.
  ## Examples
      iex> get_rsvp!(123)
      %Rsvp{}
      iex> get_rsvp!(456)
      ** (Ecto.NoResultsError)
  """
  def get_rsvp!(id), do: Repo.get!(Rsvp, id)

  def load_post(%Rsvp{} = rsvp) do
    rsvp = Repo.preload(rsvp, :post)
    post = Events.Posts.load_rsvps(rsvp.post)
    %{ rsvp | post: post }
  end

  @doc """
  Creates a rsvp.
  ## Examples
      iex> create_rsvp(%{field: value})
      {:ok, %Rsvp{}}
      iex> create_rsvp(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """


  def create_rsvp(attrs \\ %{}) do
    %Rsvp{}
    |> Rsvp.changeset(attrs)
    |> Repo.insert(
       on_conflict: :replace_all,
       conflict_target: [:post_id, :user_id])
  end

  @doc """
  Updates a rsvp.
  ## Examples
      iex> update_rsvp(rsvp, %{field: new_value})
      {:ok, %Rsvp{}}
      iex> update_rsvp(rsvp, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_rsvp(%Rsvp{} = rsvp, attrs) do
    rsvp
    |> Rsvp.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rsvp.
  ## Examples
      iex> delete_rsvp(rsvp)
      {:ok, %Rsvp{}}
      iex> delete_rsvp(rsvp)
      {:error, %Ecto.Changeset{}}
  """
  def delete_rsvp(%Rsvp{} = rsvp) do
    Repo.delete(rsvp)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rsvp changes.
  ## Examples
      iex> change_rsvp(rsvp)
      %Ecto.Changeset{data: %Rsvp{}}
  """
  def change_rsvp(%Rsvp{} = rsvp, attrs \\ %{}) do
    Rsvp.changeset(rsvp, attrs)
  end
end
