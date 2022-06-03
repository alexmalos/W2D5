class Flight
    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    attr_reader :passengers

    def full?
        @passengers.length == @capacity
    end

    def board_passenger(passenger)
        @passengers << passenger if !full? && passenger.has_flight?(@flight_number)
    end

    def list_passengers
        @passengers.map(&:name)
    end

    def [](i)
        @passengers[i]
    end

    def <<(passenger)
        board_passenger(passenger)
    end
end