require_relative "Employee"

class Manager < Employee
    attr_reader :employees

    def initialize(name, title, salary, boss, employees = [])
        super(name, title, salary, boss)
        @employees = employees
        # @name, @title, @salary, @boss = name, title, salary, boss
    end 

    def bonus(mult)
        employees.map(&:salary).sum * mult
    end

    def add_employee(employee)
        employees << employee
    end
end 