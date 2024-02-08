require './config/environment'

run ApplicationController
ApplicationController.subclasses.each do |controller|
    use controller
end
