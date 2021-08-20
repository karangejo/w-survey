defmodule WSurveyWeb.WuhanSurveyController do
  use WSurveyWeb, :controller

  alias WSurvey.Surveys.WuhanSurvey

  def wuhan_vote(conn, %{"vote" => vote})do
    case WuhanSurvey.wuhan_vote(vote) do
      {:ok, survey} ->
        render(conn, "survey.json", survey: survey)
      {:error, error} ->
        render(conn, "error.json", error: error)
    end
  end

  def wuhan_count(conn, _) do
    count = WuhanSurvey.wuhan_count()
    render(conn, "count.json", count: count)
  end
end
