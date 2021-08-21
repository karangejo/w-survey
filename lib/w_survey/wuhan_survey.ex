defmodule WSurvey.Surveys.WuhanSurvey do
  alias WSurvey.Surveys.Survey
  alias WSurvey.Repo
  import Ecto.Query

  def wuhan_count() do
    w_survey =
      Survey
      |> where(question: "The Wuhan coronavirus was created by China.")
      |> Repo.one()

    {:ok,
     %{
       agree: w_survey.agree,
       disagree: w_survey.disagree,
       total: w_survey.agree + w_survey.disagree
     }}
  end

  def wuhan_vote(vote) when vote in ["agree", "disagree"] do
    case Repo.transaction(fn ->
           w_survey =
             Survey
             |> where(question: "The Wuhan coronavirus was created by China.")
             |> lock("FOR UPDATE")
             |> Repo.one()

           changeset =
             case vote do
               "agree" ->
                 Survey.changeset(w_survey, %{agree: w_survey.agree + 1})

               "disagree" ->
                 Survey.changeset(w_survey, %{disagree: w_survey.disagree + 1})
             end

           Repo.update(changeset)
         end) do
      {:ok, survey} ->
        survey

      _ ->
        {:error, "Database error"}
    end
  end

  def wuhan_vote(_), do: {:error, "Invalid input. Try one of 'agree' or 'disagree'."}
end
