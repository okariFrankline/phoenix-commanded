defmodule Turbo do
  @moduledoc """
  Turbo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  use Commanded.Application, otp_app: :turbo

  alias Turbo.Todos

  router(Todos.Router)
end
