require 'csv'

desc "Import data from csv files"
task :import_csv => [:environment] do
  files = {
    'data/merchants.csv' => Merchant,
    'data/customers.csv' => Customer,
    'data/items.csv' => Item,
    'data/invoices.csv' => Invoice,
    'data/invoice_items.csv' => InvoiceItem,
    'data/transactions.csv' => Transaction
  }

  files.each do |path, model|
    CSV.foreach(path, headers: true) do |row|
      model.create!(row.to_hash)
    end
  end
end
