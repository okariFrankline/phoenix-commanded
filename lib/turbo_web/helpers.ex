defmodule TurboWeb.Helpers do
  @moduledoc """
  Helper functions that will be made available in all controllers
  """

  alias Ecto.Changeset

  @doc """
  Given validation errors returned from middlewares, it changes it
  into changeset errors for easier rendering in templates

  The function passed should return a changeset as it's result
  """
  @spec validation_errors(fun :: (() -> Changeset.t()), errors :: map) :: Changeset.t()
  def validation_errors(fun, errors) when is_function(fun, 0) do
    fun.()
    |> Map.put(:errors, errors)
    |> Map.put(:action, :validate)
  end
end
