defmodule WSurveyWeb.WuhanSurveyResolver do
  alias WSurvey.Surveys.WuhanSurvey

  def vote_count(_root, _args, _info) do
    WuhanSurvey.wuhan_count()
  end

  def vote(_root, %{vote: vote}, _info) do
    WuhanSurvey.wuhan_vote(vote)
  end

end
