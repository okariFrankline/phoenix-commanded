defmodule Turbo.Middlewares.Validate do
  @moduledoc false

  @behaviour Commanded.Middleware

  alias Commanded.Middleware
  alias Middleware.Pipeline

  import Pipeline

  @doc false
  @impl Middleware
  def before_dispatch(%Pipeline{command: command} = pipeline) do
    if Vex.valid?(command), do: pipeline, else: errors(pipeline)
  end

  defp errors(%Pipeline{command: command} = pipeline) do
    errors = command |> Vex.errors() |> translate_errors() |> IO.inspect(label: "Vex errors")

    pipeline
    |> respond({:error, :validation_errors, errors})
    |> halt()
  end

  defp translate_errors(errors) do
    errors
    |> Enum.group_by(fn {_error, field, _type, _msg} -> field end, fn {_, _, _, msg} -> msg end)
    |> Enum.into(%{})
  end

  @doc false
  @impl Middleware
  def after_dispatch(pipeline), do: pipeline

  @impl Middleware
  def after_failure(pipeline), do: pipeline
end
