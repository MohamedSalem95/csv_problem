require 'csv'

data = CSV.parse(File.read('input.csv'))

# [["1", "Minneapolis", "shoes", "2", "Air"], ["2", "Chicago", "shoes", "1", "Air"], ["3", "Central Department Store", "shoes", "5", "BonPied"], ["4", "Quail Hollow", "forks", "3", "Pfitzcraft"]]


# FIRST PROBLEM CALCULATING THE AVERAGE FOR EACH PRODUCT
###################################################################################################
###################################################################################################

# returns an array grouping [product, quantity]
group_product_quantity = data.map { |line| [line[2], line[3]] }

# returns array of products
array_of_products = data.map { |line| line[2] }


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
# puts 'Please Enter first file name 0_file_name '
# first_name = gets
# puts first_name

# write to csv
CSV.open('file_1.csv', 'w') do |file|
    first_csv.each { |line| file << line }
end

puts 'first file created successfully'




# SECOND PROBLEM FINDING THE MOST POPULAR BRAND FOR EACH PRODUCT
###################################################################################################
###################################################################################################

# returns an array grouping [product, brand]
group_product_brand = data.map { |line| [line[2], line[4]] }

product_brand_count = array_of_products.uniq.map do |product|
    product_with_brand_for_this_product = group_product_brand.filter do |el|
        el[0] == product
    end

    array_of_brands = product_with_brand_for_this_product.map { |p1| p1[1] }
    brands_with_total_count = array_of_brands.uniq.map do |brand|
        total = 0
        product_with_brand_for_this_product.map do |p2|
            if p2[1] == brand
                total += 1
            end
        end
        [product, brand, total]
    end
    brands_with_total_count
end


brand_with_count_final = product_brand_count.map do |el|
    array_of_brand_count = el.map do |el2|
        el2[2]
    end
    brand_with_biggest_count = array_of_brand_count.max
    filtered_array = el.filter do |el3|
        el3[2] == brand_with_biggest_count
    end
    filtered_array
end

second_csv = brand_with_count_final.map do |el|
    [el[0][0], el[0][1]]
end



CSV.open('file_2.csv', 'w') do |file|
    second_csv.each { |line| file << line }
end

puts 'second file created successfully'
###################################################################################################
###################################################################################################
# THAT WAS ALOT OF FUN TRYING TO SOLVE THESS PROBEMS
# THANK YOU