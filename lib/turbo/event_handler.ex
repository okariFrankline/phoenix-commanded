defmodule Turbo.EventHandler do
  @moduledoc """
  A behaviour module that makes definition of event handlers easier
  """

  @default_options [
    application: Turbo,
    start_from: :origin,
    consistency: :strong
  ]

  @doc false
  def __using__(opts) do
    opts = validate_options(opts)

    quote location: :keep, bind_quoted: [opts: opts] do
      use Commanded.Event.Handler, opts
    end
  end

  defp validate_options(opts) do
    opts
    |> ensure_name()
    |> maybe_add_defaults()
  end

  defp ensure_name(opts) do
    case Keyword.fetch(opts, :name) do
      {:ok, _} -> opts
      :error -> raise_name_required(opts)
    end
  end

  defp raise_name_required(opts) do
    raise("""
    Expected the `:name` option to be provided, instead got #{inspect(opts)}
    """)
  end

  defp maybe_add_defaults(opts) do
    for {key, value} <- @default_options, reduce: opts do
      opts ->
        case Keyword.fetch(opts, key) do
          {:ok, _} -> opts
          :error -> Keyword.put_new(opts, key, value)
        end
    end
  end
end
