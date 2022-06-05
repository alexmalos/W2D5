require_relative "item"

class List
    SPACER = '-------------------------------------------------'

    def initialize(label)
        @label = label
        @items = []
    end
    
    attr_accessor :label

    def add_item(title, deadline, description = "")
        return false unless Item.valid_date?(deadline)
        @items << Item.new(title, deadline, description)
        true
    end

    def size
        @items.length
    end

    def valid_index?(index)
        (0...@items.length).include?(index)
    end

    def swap(index_1, index_2)
        return false unless valid_index?(index_1) && valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        @items[index]
    end

    def priority
        @items[0]
    end

    def print
        puts SPACER
        puts '                ' + @label.upcase
        puts SPACER
        puts 'Index | Item                 | Deadline   | Done'
        puts SPACER
        @items.each_with_index do |item, i|
            item.done ? check = "✓" : check = " "
            puts "#{i.to_s.ljust(6)}| #{item.title.ljust(21)}| #{item.deadline} | [#{check}]"
        end
        puts SPACER
    end

    def print_full_item(index)
        return unless valid_index?(index)
        puts SPACER
        @items[index].done ? check = "✓" : check = " "
        puts "#{@items[index].title.ljust(32)}#{@items[index].deadline.ljust(14)}[#{check}]"
        puts @items[index].description
        puts SPACER
    end

    def print_priority
        print_full_item(0)
    end
    
    def up(index, amount = 1)
        return false unless valid_index?(index)
        amount.times do
            return true if index == 0
            swap(index, index - 1)
            index -= 1
        end
        true
    end

    def down(index, amount = 1)
        return false unless valid_index?(index)
        amount.times do
            return true if index == @items.length - 1
            swap(index, index + 1)
            index += 1
        end
        true
    end

    def sort_by_date!
        @items.sort_by!(&:deadline)
    end

    def toggle_item(index)
        @items[index].toggle
    end

    def remove_item(index)
        return false unless valid_index?(index)
        @items.delete_at(index)
        true
    end

    def purge
        @items.select(&:done).each { |item| @items.delete(item) }
    end
end