defmodule Turbo.Todos.Events.TaskUpdated do
  @moduledoc false

  @derive [Jason.Encoder]
  defstruct [
    :task_uuid,
    :title,
    :due_date
  ]

  use ExConstructor
end
