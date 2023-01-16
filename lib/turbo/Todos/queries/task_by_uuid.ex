defmodule Turbo.Todos.Queries.TaskByUuid do
  @moduledoc """
  Returns a query for a given task using the uuid provided
  """

  import Ecto.Query, only: [where: 3]

  alias Turbo.Todos.Projections.Task

  @doc false
  @spec new(uuid :: String.t()) :: Ecto.Query.t()
  def new(uuid) do
    where(Task, [t], t.uuid == ^uuid)
  end
end
