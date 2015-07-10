class ToolImport
  extend ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations
  
  #attr_accessor :file
  

  def persisted?
    false
  end

 # attr_accessible :id, :name, :description, :image, :serial, :barcode, :date_purchased, :capability, :reservable, :max_reservation_time, :category_ids

  def self.imported_tool
    
  end
  def self.import(file)
    errors = ActiveModel::Errors.new(self)
    @file = file[:file]
    imported_tool ||= self.load_imported_tool
    if imported_tool.empty?
      true
    else
      imported_tool.each_with_index do |tool, index|
        tool.full_messages.each do |message|
          errors.add :base, "Row #{index+2}: #{message}"
        end
      end
      return errors
    end
  end
  def self.load_imported_tool
    case File.extname(@file.original_filename)
    when ".csv" then 
      tools = Array.new
      CSV.foreach(@file.path, headers: true) do |i|
        row = i
        tool = Tool.find_by_id(row["id"]) || Tool.new
        tool.name = row["name"] if row["name"]
        tool.description = row["description"] if row["description"]
        tool.image = row["image"] if row["image"]
        tool.serial = row["serial"] if row["serial"]
        tool.barcode = row["barcode"] if row["barcode"]
        tool.date_purchased = row["date_purchased"] if row["date_purchased"]
        tool.capability = row["capability"] if row["capability"]
        tool.reservable = row["reservable"] if row["reservable"]
        tool.max_reservation_time = row["max_reservation_time"] if row["max_reservation_time"]
        
        if row["category_ids"]
          cat_ids = row["category_ids"].split(',')
          tool.category_ids =  cat_ids
        end
        
        if !tool.save
          tools.push tool.errors
        end
      end
      return tools
    else raise "Unknown file type: #{@file.original_filename}"
    end
  end
  def generate_csv
    CSV.generate do |csv|
      csv << ["name","description","image","serial","barcode","date_purchased","capability","reservable","max_reservation_time","category_ids"]
      csv << ["tool1","it does things","www.google.com/image1","adfj","123abc","2015-07-20","Other notable things","true","3","1,2"]
    end
  end
end