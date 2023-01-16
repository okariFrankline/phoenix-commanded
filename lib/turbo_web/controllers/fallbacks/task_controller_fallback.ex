defmodule TurboWeb.TaskController.Fallback do
  @moduledoc false

  use TurboWeb, :controller

  # alias Ecto.Changeset
  alias Turbo.Todos.Projections.Task

  @doc false
  def call(conn, {:error, :validation_errors, errors}) do
    fun = fn -> Task.creation_changeset(%{}) end

    conn
    |> put_status(422)
    |> put_flash(:error, "fix the errors in the inputs")
    |> render("new.html", changeset: validation_errors(fun, errors))
  end
end
