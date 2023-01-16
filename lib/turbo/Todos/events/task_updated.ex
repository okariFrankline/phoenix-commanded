defmodule Turbo.Todos.Events.TaskUpdated do
  @moduledoc false

  defstruct [
    :task_uuid,
    :title,
    :due_date
  ]

  use ExConstructor
end
