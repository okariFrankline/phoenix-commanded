defmodule Turbo.Todos.Events.TaskCreated do
  @moduledoc false

  @derive Jason.Encoder
  defstruct [
    :task_uuid,
    :title,
    :due_date
  ]

  @type t :: %__MODULE__{
          task_uuid: String.t(),
          title: String.t(),
          due_date: Date.t()
        }

  use ExConstructor
end
