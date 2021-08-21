defmodule WSurveyWeb.SchemaTest do
  use WSurveyWeb.ConnCase

  alias WSurvey.Surveys

  @wuhan_survey_attrs %{question: "The Wuhan coronavirus was created by China."}

  def fixture(:w_survey) do
    {:ok, w_survey} = Surveys.create_survey(@wuhan_survey_attrs)
    w_survey
  end

  @count_query """
  query {
    voteCount {
      agree
      disagree
      total
    }
  }
  """

  @vote_mutation """
    mutation {
      vote (vote: "agree") {
        question
        agree
        disagree
      }
    }
  """

  test "query count", %{conn: conn} do
    fixture(:w_survey)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @count_query
      })

      assert json_response(conn, 200) == %{"data" => %{"voteCount" => %{"agree" => 0, "disagree" => 0, "total" => 0}}}
  end

  test "mutation vote", %{conn: conn} do
    fixture(:w_survey)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @vote_mutation
      })

      assert json_response(conn, 200) == %{"data" => %{"vote" => %{"agree" => 1, "disagree" => 0, "question" => "The Wuhan coronavirus was created by China."}}}
  end

end
