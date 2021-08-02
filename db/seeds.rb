# List seeds here (order-sensitive!)
seed_filenames = %w[
  bike
  booking
]

seed_filenames.map do |filename|
  seed = File.join(Rails.root, "db", "seeds", "#{filename}_seeds.rb")
  puts "Seeding - #{filename}s"
  load seed
end
