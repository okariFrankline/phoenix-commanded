defmodule Turbo.Todos.Queries.EntityByUuid do
  @moduledoc """
  Given a schema module and the uuid, it returns the query for returing the
  given entity
  """

  import Ecto.Query, only: [where: 3]

  @doc false
  @spec new(module :: module(), uuid :: String.t()) :: Ecto.Query.t()
  def new(module, uuid) do
    where(module, [m], m.uuid == ^uuid)
  end
end
