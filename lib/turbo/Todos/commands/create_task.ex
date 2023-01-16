defmodule Turbo.Todos.Commands.CreateTask do
  @moduledoc false

  defstruct [
    :task_uuid,
    :title,
    :due_date
  ]

  @type t :: %__MODULE__{
          task_uuid: String.t(),
          title: String.t(),
          due_date: String.t()
        }

  use ExConstructor
  use Vex.Struct

  validates(:title,
    presence: [message: "cannot be empty"]
  )

  validates(:due_date,
    presence: [message: "cannot be empty"]
  )

  @doc "Puts the task uuid to the command"
  @spec put_uuid(command) :: command when command: t
  def put_uuid(%__MODULE__{} = cmd) do
    %__MODULE__{cmd | task_uuid: UUID.uuid4()}
  end
end
