defmodule Turbo.Validators.String do
  @moduledoc false

  use Vex.Validator

  alias Vex.Validators.By

  @doc false
  def validate(val, _) when is_nil(val) or val == "", do: :ok

  def validate(val, _) do
    By.validate(val, function: &String.valid?/1)
  end
end
