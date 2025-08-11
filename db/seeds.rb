# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Criar alguns meses
ci_months = CiMonth.create!([
  { month: 1, year: 2025, user_id: 1 },
  { month: 2, year: 2025, user_id: 1 },
  { month: 3, year: 2025, user_id: 1 }
])

# Criar entradas para cada mês
ci_months.each do |month|
  5.times do |i|
    CiEntry.create!(
      content: "Relatório #{i + 1} para #{month.month}/#{month.year}",
      date: Date.new(month.year, month.month, i + 1),
      ci_month_id: month.id,
      user_id: 1
    )
  end
end

puts "✅ Criados #{CiMonth.count} meses e #{CiEntry.count} entradas"
