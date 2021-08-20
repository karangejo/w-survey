defmodule WSurvey.RateLimiterTest do
  use WSurveyWeb.ConnCase, async: true

  alias WSurveyWeb.RateLimiter
  alias WSurvey.Surveys

  @path "/api/count"
  @rate_limit_options [max_requests: 1, interval_seconds: 60]
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
    res_list = for _ <- 1..61 do
      get(conn, Routes.wuhan_survey_path(conn, :wuhan_count))
    end
    last_conn =
      res_list
      |> Enum.reverse()
      |> List.first()

    assert json_response(last_conn, 503) == %{"errors" => %{"detail" => "Service Unavailable"}}
  end

end
