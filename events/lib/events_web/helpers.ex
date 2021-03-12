defmodule EventsWeb.Helpers do
  def loggedIn?(conn) do
    conn.assigns[:current_user] != nil
  end

  def current_user_id?(conn, user_id) do
    user = conn.assigns[:current_user]
    user && user.id == user_id
  end

  def current_user_id(conn) do
    user = conn.assigns[:current_user]
    user && user.id
  end


  def rsvpcounts(conn) do
        post = conn.assigns[:post]
	invites = post.invites
	yes = Enum.count(invites, fn x -> x.response == "Yes" end)
	maybe = Enum.count(invites, fn x -> x.response == "Maybe" end)
	no = Enum.count(invites, fn x -> x.response == "No" end)
	na = Enum.count(invites, fn x -> x.response == "n/a" end)

	to_string(yes) <> " yes, " <> 
	to_string(maybe) <> " maybe, " <>
	to_string(no) <> " no, " <>
        to_string(na) <> " n/a"
   end

  def invited?(conn, post) do
	  invites = post.invites
	  email = conn.assigns[:current_user].email
	  hasInvite =  Enum.count(invites, fn x -> x.email == email end)
	  if hasInvite > 0 do
                 true
	  end
     end 
end
