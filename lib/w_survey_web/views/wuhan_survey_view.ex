defmodule WSurveyWeb.WuhanSurveyView do
  use WSurveyWeb, :view

  def render("survey.json", %{survey: survey}) do
    %{survey: %{
      question: survey.question,
      agree: survey.agree,
      disagree: survey.disagree
    }}
  end

  def render("count.json", %{count: count}) do
    %{count: %{
      agree: count.agree,
      disagree: count.disagree,
      total: count.total
    }}
  end

  def render("error.json", %{error: error}) do
    %{error: error}
  end
end
