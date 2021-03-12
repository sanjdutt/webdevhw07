defmodule EventsWeb.PostController do
  use EventsWeb, :controller

  alias Events.Posts
  alias Events.Posts.Post
  alias EventsWeb.Plugs
  alias Events.Users
  alias Events.Invites
  plug Plugs.RequireUser when action in [:new, :create, :edit, :update, :delete]
  plug :fetch_post when action in [:show, :edit, :update, :delete]
  plug :require_owner when action in [:edit, :update, :delete]

  def fetch_post(conn, _args) do
    id = conn.params["id"]
    post = Posts.get_post!(id)
    assign(conn, :post, post)
  end

  def require_owner(conn, _args) do
    user = conn.assigns[:current_user]
    post = conn.assigns[:post]

    if user.id == post.user_id do
      conn
    else 
      conn
      |> put_flash(:error, "You must own the event to do that.")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.html", posts: posts)
  end

  def new(conn, _params) do
    changeset = Posts.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"post" => post_params}) do
    post_params = post_params
    |> Map.put("user_id", conn.assigns[:current_user].id)
    
    case Posts.create_post(post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    post = conn.assigns[:post]
   # |> Posts.load_user()
   # |> Posts.load_invites()
   #  |> Posts.load_comments()

    useID = current_user_id(conn)

    comm = %Events.Comments.Comment{
      post_id: post.id,
      user_id: current_user_id(conn), 
      vote: 0,
    }
    
    invite = %Events.Invites.Invite{ 
      post_id: post.id, 
    }
  
   user = if useID do 
     Users.get_user(useID)
   end

   response = if user do
     Invites.get_invite_by_email(user.email)
   end


    new_comment = Events.Comments.change_comment(comm)
    new_invite = Events.Invites.change_invite(invite)
    edit_invite = if response do 
        Events.Invites.change_invite(response)
    end 

    render(conn, "show.html", post: post, new_comment: new_comment, 
      new_invite: new_invite, edit_invite: edit_invite, response: response)
  end

  def edit(conn, %{"id" => id}) do
    post = conn.assigns[:post]
    changeset = Posts.change_post(post)
    render(conn, "edit.html", post: post, changeset: changeset)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = conn.assigns[:post]

    case Posts.update_post(post, post_params) do
      {:ok, post} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: Routes.post_path(conn, :show, post))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", post: post, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = conn.assigns[:post]
    {:ok, _post} = Posts.delete_post(post)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: Routes.post_path(conn, :index))
  end
end

