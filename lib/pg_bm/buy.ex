defmodule PgBm.Buy do
  use Ecto.Schema
  import Ecto.Changeset


  schema "buys" do
    field :price, :integer
    field :quantity, :integer

    timestamps()
  end

  @doc false
  def changeset(buy, attrs) do
    buy
    |> cast(attrs, [:price, :quantity])
    |> validate_required([:price, :quantity])
  end
end
