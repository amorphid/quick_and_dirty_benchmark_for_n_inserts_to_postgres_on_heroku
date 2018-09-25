defmodule PgBm.Repo.Migrations.CreateBuys do
  use Ecto.Migration

  def change do
    create table(:buys) do
      add :price, :integer
      add :quantity, :integer
      
      timestamps()
    end
    create constraint("buys", :price_must_be_greater_than_or_equal_to_zero, check: "price >= 0")
    create constraint("buys", :quantity_must_be_greater_than_or_equal_to_zero, check: "quantity >= 0")
  end
end
