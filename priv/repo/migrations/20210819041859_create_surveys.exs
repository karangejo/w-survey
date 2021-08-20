defmodule WSurvey.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :question, :string
      add :agree, :integer
      add :disagree, :integer

      timestamps()
    end

  end
end
