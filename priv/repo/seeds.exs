# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     WSurvey.Repo.insert!(%WSurvey.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias WSurvey.Repo
alias WSurvey.Surveys
alias WSurvey.Surveys.Survey

Repo.insert!(
  %Survey{
    question: "The Wuhan coronavirus was created by China."
  }
)
