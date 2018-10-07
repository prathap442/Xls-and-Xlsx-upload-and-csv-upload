class Product < ApplicationRecord
    require 'csv'
    require 'roo'
    require 'roo-xls'
    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |product|
            csv << product.attributes.values_at(*column_names)
        end
      end
    end
    
    
    
    def self.import(file)
          # binding.pry
        #   spreadsheet = open_spreadsheet(file)
        #   binding.pry 
        #   header = spreadsheet.row(1)
        #   binding.pry
        #   (2..spreadsheet.last_row).each do |i|
        #    binding.pry  
        #     #   row = Hash[[header, spreadsheet.row(i)].transpose]
        #     #   product = find_by_id(row["id"]) || new
        #     #   product.attributes = row.to_hash.slice(*accessible_attributes)
        #     #   product.save!
        #   end
        # binding.pry
        CSV.foreach(file.path,headers: true) do |row|
            a=row.to_hash
            Product.create(name:a["name"],price:a["price"])
            binding.pry
            # use row here...
        end

    end


    
    
      def self.open_spreadsheet(file)
        case File.extname(file.original_filename)
        when ".csv" then Csv.new(file.path, nil, :ignore)
        when ".xls" then Excel.new(file.path, nil, :ignore)
        when ".xlsx" then Excelx.new(file.path, nil, :ignore)
        else raise "Unknown file type: #{file.original_filename}"
        end
      end

end
