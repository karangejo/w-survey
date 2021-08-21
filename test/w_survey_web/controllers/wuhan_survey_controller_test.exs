defmodule WSurvey.WuhanSurveyControllerTest do
  use WSurveyWeb.ConnCase

  alias WSurvey.Surveys

  @wuhan_survey_attrs %{question: "The Wuhan coronavirus was created by China."}

  def fixture(:w_survey) do
    {:ok, w_survey} = Surveys.create_survey(@wuhan_survey_attrs)
    w_survey
  end

  test "can cast a vote with valid input", %{conn: conn} do
    fixture(:w_survey)
    conn = post(conn, Routes.wuhan_survey_path(conn, :wuhan_vote), vote: "agree")

    assert json_response(conn, 200) == %{"survey" => %{"agree" => 1, "disagree" => 0, "question" => "The Wuhan coronavirus was created by China."}}
  end

  test "gives error when casting a vote with invalid input", %{conn: conn} do
    fixture(:w_survey)
    conn = post(conn, Routes.wuhan_survey_path(conn, :wuhan_vote), vote: "agreeezz")

    assert json_response(conn, 200) == %{"error" => "Invalid input. Try one of 'agree' or 'disagree'."}
  end

  test "displays correct count", %{conn: conn} do
    fixture(:w_survey)
    conn = get(conn, Routes.wuhan_survey_path(conn, :wuhan_count))

    assert json_response(conn, 200) == %{"count" => %{"agree" => 0, "disagree" => 0, "total" => 0}}
  end

  test "voting displays correct count", %{conn: conn} do
    fixture(:w_survey)
    conn =
      conn
      |> post(Routes.wuhan_survey_path(conn, :wuhan_vote), vote: "agree")
      |> get(Routes.wuhan_survey_path(conn, :wuhan_count))

    assert json_response(conn, 200) == %{"count" => %{"agree" => 1, "disagree" => 0, "total" => 1}}
  end

end
