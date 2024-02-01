# student.rb

class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other)
    @grade > other.grade
  end

  protected

  def grade
    @grade
  end

end

joe = Student.new("joe", 96)
bob = Student.new("bob", 95)

# puts "Well done!" if joe.better_grade_than?(bob)