class HelloController < ApplicationController
  def index
    @message = "Hello"
    @extra = "Im the hello controller"
    @count = 2
    
  end
end
