class Tool < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_many :maintenance_types, :through=>:categories
  has_many :courses, :through=>:categories
  has_many :maintenance_actions
  has_many :tool_reservations
  has_many :tool_logs
  
  validates :name, :barcode, :presence => true
  validates :barcode, :uniqueness => true
  
  scope :reservable, ->{where(:reservable=>true)}
  
  
  def self.needs_action
    tools = Array.new
    Tool.all.each do |tool|
      if tool.needs_action?
        tools.push tool
      end
    end
    return Tool.where("id in (?)", tools.map { |x| x[:id] }).order(:name)
  end
  def needs_action?
    if self.maintenance_action_required.size <=0
      return false
    else
      return true
    end
  end
  def maintenance_action_required
    actions = Array.new
    self.maintenance_types.each do |type|
      last_action =  MaintenanceAction.where("maintenance_type_id = ? and tool_id = ?", type.id, self.id).order("date desc").first
      
      hours_ago = (type.required_days_between_maintenance).days.ago
      if last_action.nil? 
        if !self.date_purchased || self.date_purchased <= hours_ago
          #If there is no date purchased or 
          #If the date purchased <= than (longer ago than) the date which maintenance must be done (hours_ago),
          #Then add it to the list
          actions.push type
        end
      elsif last_action.date <= hours_ago
        #If the date of last maintenance <= (longer ago than) the date which maintenance must be done (hours_ago),
        #Then add it to the list
        actions.push type
      end
    end
    return actions
  end
  def checked_out
    if self.tool_logs.checked_out.nil? || self.tool_logs.checked_out.empty?
      return false
    else
      return self.tool_logs.checked_out.first
    end
  end
  
  def is_reserved?(date)
    reservations = reservation_at(date)
    if reservations.empty?
      return false
    else
      return true
    end
  end
  def reservation_at(date)
    self.tool_reservations.get_reservation_at(date)
  end
  def reservation_near(date, time_delta)
    res = self.tool_reservations.get_reservation_at(date)
    if res.empty?
      res = self.tool_reservations.get_reservation_at(date + time_delta.minutes)
      if res.empty?
        return nil
      else
        return res
      end
    else
      return res
    end
  end
  def self.search(term)
    search = term.gsub /\s+/, '%'
    ids = Array.new
    
    if search && !search.empty?
      if Rails.env == "development"
        ids = ids + Tool.where("tools.name like ? or tools.description like ? or tools.image like ? or tools.capability like ? or tools.barcode like ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%").pluck(:id)
        ids = ids +  Tool.joins(:categories).where("categories.name like ?", "%#{search}%").pluck(:id)
        ids = ids +  Tool.joins(:courses).where("courses.name like ? or courses.additional_info like ?", "%#{search}%", "%#{search}%").pluck(:id)
      else
        ids = ids + Tool.where("tools.name ILIKE ? or tools.description ILIKE ? or tools.image ILIKE ? or tools.capability ILIKE ? or tools.barcode ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}").pluck(:id)
        ids = ids +  Tool.joins(:categories).where("categories.name ILIKE ?", "%#{search}%").pluck(:id)
        ids = ids +  Tool.joins(:courses).where("courses.name ILIKE ? or courses.additional_info ILIKE ?", "%#{search}%", "%#{search}%").pluck(:id)
      end
      
      
      Tool.where("id in (?)", ids.uniq)
    else
      Tool.none
    end
  end
  def self.import(file)
    require 'csv'
    tools = Array.new
    CSV.foreach(file.path, headers: true) do |row|
      tool = Tool.create! row.to_hash
      tools.push tool
    end
    
    return tools
  end
end
