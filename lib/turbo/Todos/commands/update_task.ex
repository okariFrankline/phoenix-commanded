defmodule Turbo.Todos.Commands.UpdateTask do
  @moduledoc false

  defstruct [
    :title,
    :task_uuid,
    :due_date
  ]

  @type t :: %__MODULE__{
          title: String.t(),
          due_date: Date.t(),
          task_uuid: String.t()
        }

  use ExConstructor
  use Vex.Struct

  validates(:task_uuid, presence: [message: "cannot be blank"])

  validates(:title,
    presence: [message: "cannot be blank"],
    string: true
  )

  validates(:due_date,
    presence: [message: "cannot be blank"],
    string: true
  )

  @doc "Given the uuid, it inserts it to the command"
  @spec put_uuid(cmd :: t, uuid :: String.t()) :: cmd :: t()
  def put_uuid(%__MODULE__{} = cmd, uuid), do: %__MODULE__{cmd | task_uuid: uuid}
end
