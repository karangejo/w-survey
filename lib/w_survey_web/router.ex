defmodule WSurveyWeb.Router do
  use WSurveyWeb, :router
  import WSurveyWeb.RateLimiter

  pipeline :api do
    plug(:accepts, ["json"])
    plug(:rate_limit, max_requests: 60, interval_seconds: 60)
  end

  scope "/api" do
    pipe_through(:api)

    get("/count", WSurveyWeb.WuhanSurveyController, :wuhan_count)
    post("/vote", WSurveyWeb.WuhanSurveyController, :wuhan_vote)

    forward "/graphql", Absinthe.Plug, schema: WSurveyWeb.Schema

    forward("/graphiql", Absinthe.Plug.GraphiQL,
      schema: WSurveyWeb.Schema,
      interface: :playground,
      context: %{pubsub: WSurveyWeb.Endpoint}
    )
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through([:fetch_session, :protect_from_forgery])
      live_dashboard("/dashboard", metrics: WSurveyWeb.Telemetry)
    end
  end
end
