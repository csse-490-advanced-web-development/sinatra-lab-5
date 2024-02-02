require_relative "../spec_helper"

# bop

def app
  TasksController
end

describe TasksController do

  # I typically shirk unit testing controllers unless
  # the controller does something fancy.
  #
  # However, fancy things are best done in model and
  # utility classes, and thus should be unit tested
  # in those model and utility classes' specs.

end
