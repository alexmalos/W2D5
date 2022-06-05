class Item
    def self.valid_date?(date_string)
        date = date_string.split("-").map(&:to_i)
        return true if (date.length == 3 &&
            date[0].digits.count == 4 &&
            (1..12).include?(date[1]) &&
            (1..31).include?(date[2]))
        false
    end

    def initialize(title, deadline, description)
        raise ArgumentError.new "Invalid deadline" unless Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end
    
    attr_accessor :title, :description
    attr_reader :deadline, :done

    def deadline=(new_deadline)
        raise ArgumentError.new "Invalid deadline" unless Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end
    
    def toggle
        @done = !@done
    end
end