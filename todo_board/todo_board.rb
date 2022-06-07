require_relative "list"

class TodoBoard
    def initialize
        @board = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, label, *args  = gets.chomp.split
        
        case cmd
            when 'mklist'
                @board[label] = List.new(label)
            when 'ls'
                @board.each_key { |key| puts " #{key}" }
            when 'showall'
                @board.each_value(&:print)
            when 'mktodo'
                @board[label].add_item(*args)
            when 'toggle'
                @board[label].toggle_item(*args.map(&:to_i))
            when 'rm'
                @board[label].remove_item(*args.map(&:to_i))
            when 'purge'
                @board[label].purge
            when 'up'
                @board[label].up(*args.map(&:to_i))
            when 'down'
                @board[label].down(*args.map(&:to_i))
            when 'swap'
                @board[label].swap(*args.map(&:to_i))
            when 'sort'
                @board[label].sort_by_date!
            when 'priority'
                @board[label].print_priority
            when 'print'
                args.empty? ? @board[label].print : @board[label].print_full_item(*args.map(&:to_i))
            when 'quit'
                return false
            else
                print "Sorry, that command is not recognized."
        end

        true
    end

    def run
        running = true
        running = get_command while running
    end
end

TodoBoard.new.run