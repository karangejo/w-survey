defmodule WSurveyWeb.RateLimiter do

  import Plug.Conn, only: [put_status: 2, halt: 1]
  import Phoenix.Controller, only: [render: 2, put_view: 2]
  require Logger

  def rate_limit(conn, opts \\ []) do
    case check_rate(conn, opts) do
      {:ok, _count} ->
        conn

      error ->
        Logger.info(rate_limit: error)
        render_error(conn)
    end
  end

  defp check_rate(conn, opts) do
    interval_ms = Keyword.fetch!(opts, :interval_seconds) * 1000
    max_requests = Keyword.fetch!(opts, :max_requests)
    ExRated.check_rate(bucket_name(conn), interval_ms, max_requests)
  end

  defp bucket_name(conn) do
    conn.remote_ip
    |> Tuple.to_list()
    |> Enum.join(".")
  end

  defp render_error(conn) do
    conn
    |> put_status(:service_unavailable)
    |> put_view(WSurveyWeb.ErrorView)
    |> render(:"503")
    |> halt()
  end
end
