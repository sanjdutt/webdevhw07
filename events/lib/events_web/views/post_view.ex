defmodule EventsWeb.PostView do
  use EventsWeb, :view

alias Events.Posts.Post

  def render_json(%Post{} = post) do
    %{
      id: post.id,
      score: post.score
    }
  end
  
  def render_json(_missing), do: {}
end
