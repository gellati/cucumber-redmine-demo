require "capybara/cucumber"

HOST = 'http://localhost' # change url
USERNAME = "user"
PASSWORD = "bitnami1"

USER_PAGE = HOST + '/users'
GROUPS_PAGE = HOST + '/groups'
PLUGIN_PAGE = HOST + '/admin/plugins'
NEW_GROUP_PAGE = HOST + '/groups/new'
NEW_USER_PAGE = HOST + '/users/new'

USER_PAGE_LOGIN='Login'
USER_PAGE_FIRST_NAME='First name'
USER_PAGE_LAST_NAME='Last name'
USER_PAGE_EMAIL='Email'
USER_PAGE_ADMINISTRATOR='Administrator'
USER_PAGE_CREATED='Created'
USER_PAGE_LAST_CONNECTION='Last connection'

TEST_GROUP = 'Ticket reporters'
TEST_USER_LOGIN = 'Johnny'
TEST_USER_FIRST_NAME = 'John'
TEST_USER_LAST_NAME = 'Doe'
TEST_USER_FULL_NAME = "John Doe"
TEST_USER_EMAIL = 'john.doe@example.com'
TEST_USER_PASSWORD = '123password'




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

Given(/^user is at user page$/) do
  visit USER_PAGE
  expect(page.has_content?('New user'))
  expect(page.has_content?('Users'))
end


## Click links

When(/^user clicks Redmine Sign in link$/) do
  find('.login').click
end

When(/^user clicks forgot password link$/) do
  find('#login-form a.lost_password').click
end

When(/^user clicks Redmine administration link$/) do
  find('.administration').click
end

When(/^user clicks plugins link$/) do
  find('.plugins').click
end

When(/^user clicks users link$/) do
  expect(page.has_content?('Users'))
  find('.users').click
end

When(/^user clicks groups link$/) do
  find('.groups').click
end

When(/^user clicks New group link$/) do
  find('a.icon-add').click
end


## Click elements

When(/^user clicks submit button$/) do
  find('input[type="submit"]').click
end

When(/^user clicks login button$/) do
  find('#login-submit').click
end

When(/^user clicks New user button$/) do
  find('.icon-add').click
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

Then(/^user is redirected to Plugin page$/) do
  expect(page.has_content?('Plugins'))
  expect(page).to have_current_path(PLUGIN_PAGE)
end

Then(/^user is directed to user page$/) do
  expect(page.has_content?('New user'))
end

When(/^user is redirected to Groups page$/) do
  expect(page.has_content?('Groups'))
  expect(page.has_content?('New group'))
  expect(page).to have_current_path(GROUPS_PAGE)
end

When(/^user is redirected to New group page$/) do
  expect(page.has_content?('New group'))
  expect(page).to have_current_path(NEW_GROUP_PAGE)
end

Then(/^user should be redirected to Groups page$/) do
  expect(page.has_content?('Groups'))
  expect(page).to have_current_path(GROUPS_PAGE)
end

When(/^user is redirected to New user page$/) do
  expect(page.has_content?('New user'))
  expect(page).to have_current_path(NEW_USER_PAGE)
end


## Fill in fields

When(/^user fills in email field with "([^"]*)"$/) do |arg1|
  find('input#mail').send_keys(arg1)
end

When(/^user fills in valid username and valid password$/) do
  find('#username').send_keys(USERNAME)
  find('#password').send_keys(PASSWORD)
end


## Page contents

Then(/^page contains text that no valid login detail is found with given address$/) do
  expect(page.has_content?('Unknown user'))
end

Then(/^user can see a valid user page$/) do
  content = ['user', 'USER_PAGE_FIRST_NAME', 'USER_PAGE_LAST_NAME',
             'USER_PAGE_EMAIL', 'USER_PAGE_ADMINISTRATOR', 'USER_PAGE_CREATED',
             'USER_PAGE_LAST_CONNECTION']
  content.each{|c|
    expect(page.has_content?(c))
  }
end

Then(/^page should contain the new group name$/) do
  expect(page.has_content?(TEST_GROUP))
end

Then(/^the Groups page should not contain the group$/) do
  expect(page.has_no_content?(TEST_GROUP))
end

Then(/^user can see a new user has been created$/) do
  expect(page.has_content?(TEST_USER_LOGIN))
end

Then(/^users page should not contain the user$/) do
  expect(page.has_no_content?(TEST_USER_LOGIN))
end

Then(/^group table contains the new user$/) do
  expect(page.has_content?(TEST_USER_FULL_NAME))
end

Then(/^the group member page should not contain the user$/) do
  expect(page.has_no_content?(TEST_USER_FULL_NAME))
end




## Other

When(/^user creates a new group$/) do
  find('#group_name').send_keys(TEST_GROUP)
  find('input[value="Create"]').click
end

When(/^user deletes a group from the Groups page$/) do
  find(:xpath, '//table//tr[*=\'' + TEST_GROUP + '\']//a[contains(text(), "Delete")]').click
  page.accept_alert
end

When(/^user creates new user$/) do
  dictionary = {'#user_login' => TEST_USER_LOGIN,
                '#user_firstname' => TEST_USER_FIRST_NAME,
                '#user_lastname' => TEST_USER_LAST_NAME,
                '#user_mail' => TEST_USER_EMAIL,
                '#user_password' => TEST_USER_PASSWORD,
                '#user_password_confirmation' => TEST_USER_PASSWORD
                }
  dictionary.each do |key,value|
    find(key).send_keys(value)
  end
  find('input[value="Create"]').click
end

When(/^user deletes a user from the users page$/) do
  find('a.users').click
  expect(page.has_content?('Users'))
  expect(page.has_content?('New user'))
  expect(page).to have_current_path(USER_PAGE)
  find(:xpath, '//table//tr[ * = \'' + TEST_USER_LOGIN + '\']//td[@class="buttons"]//a[contains(text(), "Delete")]').click
  page.accept_alert
end

When(/^user adds a new user to the group$/) do
  find(:xpath, '//a[contains(text(), "' + TEST_GROUP + '")]').click
  find(:xpath, '//a[@id="tab-users"]').click
  find('.icon-add').click
  expect(page).to have_xpath('//div[@id="ajax-modal"]')
  find('#user_search').send_keys(TEST_USER_FULL_NAME)
  find(:xpath, '//div[@id="principals"]//label[contains(text(), "'+ TEST_USER_FULL_NAME + '")]').click  #.set(true)
  click_on('Add')
end

When(/^user deletes a user from the group$/) do
  find(:xpath, '//a[contains(text(), "' + TEST_GROUP + '")]').click
  find(:xpath, '//a[@id="tab-users"]').click
  find(:xpath, '//table//tr[ * = "' + TEST_USER_FULL_NAME + '"]//td[@class="buttons"]//a[contains(text(), "Delete")]').click
  page.accept_alert
end
