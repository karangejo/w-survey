defmodule WSurvey.RateLimiterTest do
  use WSurveyWeb.ConnCase, async: true

  alias WSurvey.Surveys

  @wuhan_survey_attrs %{question: "The Wuhan coronavirus was created by China."}

  def fixture(:w_survey) do
    {:ok, w_survey} = Surveys.create_survey(@wuhan_survey_attrs)
    w_survey
  end

  setup do
    bucket_name = "127.0.0.1"

    on_exit(fn ->
      ExRated.delete_bucket(bucket_name)
    end)
  end

  test "does not display error before rate limit", %{conn: conn} do
    fixture(:w_survey)
    for _ <- 1..60 do
      conn = get(conn, Routes.wuhan_survey_path(conn, :wuhan_count))
      assert json_response(conn, 200) == %{"count" => %{"agree" => 0, "disagree" => 0, "total" => 0}}
    end
  end

  test "displays error on rate limit", %{conn: conn} do
    fixture(:w_survey)
    for i <- 1..61 do
      if i <= 60 do
        conn = get(conn, Routes.wuhan_survey_path(conn, :wuhan_count))
        assert json_response(conn, 200) == %{"count" => %{"agree" => 0, "disagree" => 0, "total" => 0}}
      else
        conn = get(conn, Routes.wuhan_survey_path(conn, :wuhan_count))
        assert json_response(conn, 503) == %{"errors" => %{"detail" => "Service Unavailable"}}
      end
    end
  end

end
