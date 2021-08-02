# Service objects should inherit from this class.
class Service
  # Helper method to allow service classes to be called as ExampleService.run(params)
  def self.run(*params)
    new(*params).run
  end
end
