require "capybara/cucumber"

HOST = 'http://localhost' # change url
USERNAME = "user"
PASSWORD = "bitnami1"


Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = HOST
end


##  Locations

Given(/^user is at Redmine$/) do
  visit HOST
end

Given(/^user is at the password restore page$/) do
  visit 'http://localhost/account/lost_password'
  expect(page.has_content?('Lost password'))
  expect(page).to have_current_path(HOST + '/account/lost_password')
end


## Click links

When(/^user clicks Redmine Sign in link$/) do
  find('.login').click
end

When(/^user clicks forgot password link$/) do
  find('#login-form a.lost_password').click
end

## Redirections

And(/^user is redirected to authentication$/) do
  expect(page.has_content?('Login'))
  expect(page).to have_current_path(HOST + '/login')
end

Then(/^user is directed into password restore page$/) do
  expect(page.has_content?('Lost password'))
end

Then(/^user is redirected to Redmine as a logged in user$/) do
  expect(page.has_content?('Logged in as'))
end

## Fill in fields

When(/^user fills in email field with "([^"]*)"$/) do |arg1|
  find('input#mail').send_keys(arg1)
end

When(/^user fills in valid username and valid password$/) do
  find('#username').send_keys(USERNAME)
  find('#password').send_keys(PASSWORD)
end

## Click elements

When(/^user clicks submit button$/) do
  find('input[type="submit"]').click
end

When(/^user clicks login button$/) do
  find('#login-submit').click
end

## Page contents

Then(/^page contains text that no valid login detail is found with given address$/) do
  expect(page.has_content?('Unknown user'))
end
