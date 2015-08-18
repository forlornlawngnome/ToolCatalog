class Hour < ActiveRecord::Base
  belongs_to :person
  
  validates :time_open, :time_close, :day_of_week, :presence => true
  
  def self.hours_now?
    exceptions = HourException.now.pluck(:person_id)
    #raise exceptions.inspect
    if !exceptions.empty?
      hours = Hour.where("day_of_week = ? and person_id not in (?)", DateTime.now.wday, exceptions)
    else
      hours = Hour.where("day_of_week = ?", DateTime.now.wday)
    end
   
    
    hours.each do |hour|
      if hour.time_open.strftime("%H%M%S%N") <= DateTime.now.strftime( "%H%M%S%N" ) && hour.time_close.strftime( "%H%M%S%N" ) >= DateTime.now.strftime( "%H%M%S%N" )
        return true
      end
    end
    return false
  end
  def actual_hours
    exceptions = self.has_exception

    real_hours = {:times =>{0=>{:open =>self.time_open,:close=>self.time_close}}}
    if exceptions.nil? || exceptions.empty?
      return real_hours
    else 
      real_hours = {:times =>{}}
      exceptions.each do |ex|
        if ex.time_beginning.strftime( "%H%M%S%N" ) >= self.time_close.strftime( "%H%M%S%N" )
          #If the exception is entirely after the hours availlable
          #Then no hours modified for this exception so do nothing
          real_hours[:times][0] = {:open => self.time_open, :close => self.time_close}
        elsif  ex.time_ending.strftime( "%H%M%S%N" ) <=self.time_open.strftime( "%H%M%S%N" )
          #If the exception ends entirely before the hours open
          #Then no hours modified for this exception so do nothing
          real_hours[:times][0] = {:open => self.time_open, :close => self.time_close}
        else
          if real_hours[:times][0] && !real_hours[:times][0].empty? && real_hours[:times][0][:open].strftime( "%H%M%S%N" )==self.time_open.strftime( "%H%M%S%N" ) && real_hours[:times][0][:close].strftime( "%H%M%S%N" )==self.time_close.strftime( "%H%M%S%N" )
            real_hours[:times].delete(0)
          end
          if ex.time_beginning.strftime( "%H%M%S%N" ) <= self.time_open.strftime( "%H%M%S%N" )
            #If the exception start time is before the hours start
            if ex.time_ending.strftime( "%H%M%S%N" ) >= self.time_close.strftime( "%H%M%S%N" )
              #If the exception starts before the hours and ends after the hours, there are no hours to be had. Return null.
              return {:times=>{}}
            else
              #otherwise the exception must end before the end of the hours
              #Therefore set the hours to begin at the end of the exception
              real_hours[:times][ex.id] = {:open => ex.time_ending, :close => self.time_close}
            end
          else
            #If the exception start time is after the start of hours
            if ex.time_ending.strftime( "%H%M%S%N" ) >= self.time_close.strftime( "%H%M%S%N" )
              #If it ends after the hours
              #Then the hours end at the beginning of the exception
              real_hours[:times][ex.id] = {:open => self.time_open, :close => ex.time_beginning}
            else
              #If the end hours are before the end of the time, the time is split in two
              real_hours[:times]["first_#{ex.id}"] = {:open => self.time_open, :close => ex.time_beginning}
              real_hours[:times]["second_#{ex.id}"] = {:open => ex.time_ending, :close => self.time_close}
            end
          end
        end
      end
      #May need to write cleanup function if it becomes a problem
      
      if self.day_of_week ==6
        return cleanup_hours(real_hours[:times].values.sort_by{|name| (name[:open]).strftime( "%H%M%" )})
      else
        return real_hours
      end
      #return real_hours
    end
  end
  def cleanup_hours(hours)
    if hours.size <=1
      hour = hours.first
      hours = {:times=>{1=>hour}}
      return hours
    end
    
    new_times = {}
    i=0
    hours.each do |hour|
      new_times[i] = hour
      i= i+1
    end

    comp_times = {}
    
    
    real_hours = {:times =>{}}
    
    
    (1..hours.size-1).each do |j|
      comp_times = compare_times(new_times[j-1], new_times[j])
      if !comp_times[:open]
        real_hours[:times][j]=comp_times[0]
        new_times[j] = comp_times[1]
        new_times.delete(j-1)
      else
        new_times.delete(j-1)
        new_times[j]= comp_times
      end
      
      if (hours.size - 1) == j
        
        real_hours[:times][j+1] = new_times[j]
        return real_hours
      end
    end
    
    #raise comp_times.inspect
    
    return real_hours
  end
  def has_exception
    d = Date.today
   
    (d.at_beginning_of_week...d.end_of_week).each do |weekday|
      if weekday.strftime("%A") == Date::DAYNAMES[self.day_of_week]
        exceptions = HourException.where("time_beginning >= ? and time_beginning < ? and person_id = ?",weekday.at_beginning_of_day,weekday.at_end_of_day, self.person.id).order(:time_beginning)
        return exceptions
      end
    end
    
  end
  private
    def compare_times(t1, t2)
      if t1 && t2 && t1[:open].strftime( "%H%M%" ) == t2[:open].strftime( "%H%M%" )
        #If they start at the same time...
        if t2[:close].strftime( "%H%M%" ) > t2[:close].strftime( "%H%M%" )
          #...and first one ends after the second, 
          #Start it at the start time, and end it at second end time since it's earlier
          return {:open => t1[:open], :close => t2[:close]}
        else
          #...and second one ends after the first, 
          #Start it at the start time, and end it at first end time since it's earlier
          return {:open => t1[:open], :close => t2[:close]}
        end
      elsif t1 && t2 && t1[:open].strftime( "%H%M%" ) < t2[:open].strftime( "%H%M%" )
        #If the first one has an earlier start time...
        if t1[:close].strftime( "%H%M%" ) >= t2[:open].strftime( "%H%M%" )
          
          #...And the first one ends after the second begins...
          if t1[:close].strftime( "%H%M%" ) >= t2[:close].strftime( "%H%M%" )
            #...If the first one ends after the second
            #Then return the start time of the first (latest) and the close time of the second (earlier)
            return {:open => t2[:open], :close => t2[:close]}
          else
            #...If the second one ends after the first
            #Then return the start time of the first (latest) and the close of the first (earlier)
            return {:open => t2[:open], :close => t1[:close]}
          end
        else
          #...And the first one ends before the second begins...
          val = {}
          val[0] = t1
          val[1] = t2
          return val
        end
      else
        #if the first starts after the second. Can't get here because it's sorted. Hopefully :)
        raise [t1,t2].inspect
      end
      return {}
    end
end
