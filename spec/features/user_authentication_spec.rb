require_relative '../spec_helper'

# In order to implement the next stage of this lab, you will need to put
# together a lot of the skills that you were walked through in Lab 3:
# - Create a UsersController (reference the TasksController class)
# - Create a route in UsersController that matches the "Sign Up" link route
# - Implement the form for creating a new user
# - Implement the User class (reference the Task class)
# - Create a migration to generate the users table
#   - use `db:create_migration` rake task for this
#     - e.g. `rake db:create_migration create_users`
#     - FYI: The commmand `rake -D` has details on each of the rake tasks, such as which parameters to use)
# - Fill in the migration to add ONLY: a string for email, a string for password_digest, and the default timestamps (e.g. `t.timestamps null: false`)
# - After creating the migration, run it with `rake db:migrate`
# - Then, copy the schema changes over to your test database with `rake db:test:prepare`
# - Implement the route for accepting the form input (for RESTful routing, it should be a POST to "/users")
# - Add validations (and tests!) for the User model (reference spec/models/task_spec.rb for this)
# - Add a flash message to indicate whether creation of the new User was a success or a failure
#   - Hint: `flash[:notice] = "Thanks for signing up! You may now log in!"`

feature "User Authentication", js: true do
  scenario "signing up successfully and then logging in", skip: "Step 3: Unskip this test and read the instructions above" do
    visit "/"
    click_link "Sign Up"
    # ^-- This new link is in app/views/layout.erb
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "example.com is a great domain to use for testing"
    fill_in "Confirm Password", with: "example.com is a great domain to use for testing"
    click_button "Sign Up"
    page.should have_content("Thanks for signing up! You may now log in!")
    User.count.should == 1
    # ^-- For your sanity, you may want to add this line to double-check that the user record was
    #     actually created.  Strictly speaking, this doesn't belong in an integration test because
    #     integration tests are written from the perspective of the end-user, and they wouldn't be
    #     able to look into the database.
    skip "We will move on to the logging in part of the task next"
    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "example.com is a great domain to use for testing"
    click_button "Log In"
    page.should have_content("You are logged in as user@example.com")
    page.should_not have_content("Sign Up")
  end

  scenario "sign up failure", skip: "Step 3: Unskip this test and read the instructions above" do
    visit "/"
    click_link "Sign Up"
    # We are entirely skipping filling in the sign up form,
    # and then immediately click to submit the sign up form
    click_button "Sign Up"
    page.should have_content("Email can't be blank")
    fill_in "Email", with: "rosemary@example.com"
    fill_in "Password", with: "example.com is a great domain to use for testing"
    fill_in "Confirm Password", with: "I didn't type the same thing twice in a row"
    click_button "Sign Up"
    page.should have_content("Password confirmation doesn't match Password")
    # Confirm that trying again will succeed, and that
    # the form value for email been retained across pages
    find_field("Email").value.should == "rosemary@example.com"
    fill_in "Password", with: "Password1"
    fill_in "Confirm Password", with: "Password1"
    click_button "Sign Up"
    page.should have_content("Thanks for signing up! You may now log in!")

    skip "We will move on to the logging in part of the task next"
    fill_in "Email", with: "rosemary@example.com"
    fill_in "Password", with: "Password1"
    click_button "Log In"
    page.should have_content("You are logged in as rosemary@example.com")
    page.should_not have_content("Sign Up")
  end
end
