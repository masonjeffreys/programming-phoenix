defmodule Rumbl.VideoChannel do
	use Rumbl.Web, :channel

	def handle_info(:ping, socket) do
		count = socket.assigns[:count] || 1
		push socket, "ping", %{count: count}
		{:noreply, assign(socket, :count, count + 1)}
	end

	def join("videos:" <> video_id, _params, socket) do
		{:ok, assign(socket, :video_id, video_id)}
	end

	def handle_in("new_annotation", params, socket) do
		broadcast! socket, "new_annotation", %{
			user: %{username: "anon"},
			body: params["body"],
			at: params["at"]
		}
		{:reply, :ok, socket}
	end
end