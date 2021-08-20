defmodule WSurvey.Surveys.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :agree, :integer, default: 0
    field :disagree, :integer, default: 0
    field :question, :string

    timestamps()
  end

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:question, :agree, :disagree])
    |> validate_required([:question])
  end
end
