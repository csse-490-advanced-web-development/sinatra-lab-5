require_relative '../spec_helper'

feature "Managing Tasks", js: true do
  scenario "viewing the homepage with todo items" do
    expect(Task.all).to be_empty # Sanity check that the test database is empty
    task1 = Task.create(description: 'Eat breakfast')
    task2 = Task.create(description: 'Join class session')
    task3 = Task.create(description: 'Work on lab')
    visit '/'
    todo_lis = page.find_all("ul#todos li")
    todos_text = todo_lis.map{|todo_li| todo_li.text}
    expected_todos = ["Eat breakfast", "Join class session", "Work on lab"]
    todos_text.should eq expected_todos
    page.should_not have_content "This page will soon be home to a TODO app!"
    page.should_not have_content "There are no tasks remaining! You should add one!"
  end

  scenario "viewing the homepage without todo items" do
    visit "/"
    page.should_not have_content "This page will soon be home to a TODO app!"
    page.should have_content "There are no tasks remaining! You should add one!"
  end

  scenario "creating a new todo item" do
    # Note that this test doesn't stipulate that we have to do this old-school form submission.
    # We could easily upgrade this to be a SPA without this test having to change at all!
    # We happen to be implementing it as a separate page but it could just as easily be on
    # this page with no changes to the test.
    visit "/"
    click_link "Add task"
    fill_in "Task Description", with: "Follow the test instructions"
    click_button "Save"
    expect_task_list_to_be_exactly("Follow the test instructions")
  end

  scenario "creating a new todo item with HTML content Step 1: Unskip this test" do
    visit "/"
    click_link "Add task"
    fill_in "Task Description", with: "Be <strong>bold</strong> all day!"
    click_button "Save"
    # Note: This is testing that the HTML was escaped, and thus the tages
    # are text rathern than HTML elements
    expect_task_list_to_be_exactly("Be <strong>bold</strong> all day!")

    # Implementation Notes/Hints:
    #
    # 1. Read "How do I automatically escape HTML?" in the SinatraRB FAQS: https://sinatrarb.com/faq.html#escape_html
    #
    # 2. Use the gem 'erubi' (not 'erubis'!) and add it to the project by including it in the Gemfile
    #
    # 3. The place you will add that `set ...` line is in ApplicationController
    #
    # 4. In erb, to include raw text (bypassing any sanitization), use <%== your_output_with_intentional_html_in_it %>
  end

  scenario "creating a new todo with invalid data" do
    visit "/"
    click_link "Add task"
    # Note: we are skipping filling in "Task Description"!
    click_button "Save"
    page.should have_content("Description can't be blank")
    # NOTE: Eventually we will have a test along these lines in order to prove that we
    #       see appropriate errors alongside the field with errors, but we will
    #       wait to do that until we start using form builders to help us!
    # task_description_field = find_field("Task Description")
    # task_description_field.attr("validationMessage").should include "Please fill out this field"

    # NOTE: I *always* test that resubmitting the form with corrected data works
    #       because this is a common area for accidental breakage:
    fill_in "Task Description", with: "Correcting my errors works!"
    click_button "Save"
    expect_task_list_to_be_exactly("Correcting my errors works!")
  end

  scenario "updating a todo item with valid data" do
    # TODO: We are using a new tool here! Fabricate helps us create valid test data.
    # You can see the definition of this fabricator in ...
    # While the fabricator we defined is very simple now, we will expand it in
    # future tests, at which point you will really see its value.
    Task.create(description: 'Eat Breakfast')
    Task.create(description: 'Finish Lab 3, finally')
    visit '/'
    # Note that this test doesn't stipulate that we have to do this old-school form submission.
    # We can (and will!) easily upgrade this to be a SPA without this test having to change at all!
    expect_task_list_to_be_exactly("Eat Breakfast", "Finish Lab 3, finally")
    click_on "Eat Breakfast"
    find_field("Task Description").value.should eq "Eat Breakfast"
    fill_in "Task Description", with: "Eat Lunch"
    click_button "Save"
    expect_task_list_to_be_exactly("Finish Lab 3, finally", "Eat Lunch")
  end

  scenario "updating a todo item with invalid data" do
    Task.create(description: 'Eat Breakfast')
    visit '/'
    expect_task_list_to_be_exactly("Eat Breakfast")
    click_on "Eat Breakfast"
    find_field("Task Description").value.should eq "Eat Breakfast"
    fill_in "Task Description", with: "    "
    click_on "Save"
    page.should have_content("Description can't be blank")
    # NOTE: I *always* test that resubmitting the form with corrected data works
    #       because this is a common area for accidental breakage:
    fill_in "Task Description", with: "Correcting my errors works!"
    click_button "Save"
    expect_task_list_to_be_exactly("Correcting my errors works!")
  end

  scenario "deleting a todo" do
    Task.create(description: 'Eat Breakfast')
    Task.create(description: 'Join class session')
    Task.create(description: 'Finish Lab 3, finally')
    visit '/'
    expect_task_list_to_be_exactly("Eat Breakfast", "Join class session", "Finish Lab 3, finally")
    click_on "Eat Breakfast"
    click_button "Delete"

    # It would be nice to have a confirmation dialog, but I'm going for maximum simplicity here,
    # so I expect that clicking the Delete button will initiate the delete and send us back to
    # the homepage
    expect_task_list_to_be_exactly("Join class session", "Finish Lab 3, finally")
  end
end
