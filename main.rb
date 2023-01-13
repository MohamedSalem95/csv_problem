require 'csv'

data = CSV.parse(File.read('input.csv'))

# [["1", "Minneapolis", "shoes", "2", "Air"], ["2", "Chicago", "shoes", "1", "Air"], ["3", "Central Department Store", "shoes", "5", "BonPied"], ["4", "Quail Hollow", "forks", "3", "Pfitzcraft"]]

# returns an array grouping [product, brand]
group_product_brand = data.map { |line| [line[2], line[4]] }

# returns an array grouping [product, quantity]
group_product_quantity = data.map { |line| [line[2], line[3]] }

# returns array of products
array_of_products = data.map { |line| line[2] }
# puts array_of_brands.inspect

total_qantity_of_each_product = array_of_products.uniq.map do |product|
    total = 0
    group_product_quantity.map do |line|
        if line[0] == product
            total += line[1].to_i
        end
    end

    [product, total]

end

total_records = data.length

first_csv = total_qantity_of_each_product.map { |line| [line[0], (line[1].to_f / total_records)] }
puts first_csv.inspect

# get file name
puts 'Please Enter first file name 0_file_name '
first_name = gets
puts first_name

# write to csv
CSV.open('file.csv', 'wb') do |file|
    first_csv.each { |line| file << line }
end

puts 'first file created successfully'


# puts total_qantity_of_each_product.inspect


# puts group_product_brand.inspect
# puts data.inspect