defmodule WSurveyWeb.Schema do
  use Absinthe.Schema

  alias WSurveyWeb.WuhanSurveyResolver

  object :survey do
    field :question, non_null(:string)
    field :agree, non_null(:integer)
    field :disagree, non_null(:integer)
  end

  object :count do
    field :agree, non_null(:integer)
    field :disagree, non_null(:integer)
    field :total, non_null(:integer)
  end

  query do
    @desc "get vote count"
    field :vote_count, non_null(:count) do
      resolve(&WuhanSurveyResolver.vote_count/3)
    end
  end

  mutation do
    @desc "cast a vote"
    field :vote, non_null(:survey) do
      arg :vote, non_null(:string)
      resolve(&WuhanSurveyResolver.vote/3)
    end
  end

end
