defmodule WSurvey.Repo do
  use Ecto.Repo,
    otp_app: :w_survey,
    adapter: Ecto.Adapters.Postgres
end
