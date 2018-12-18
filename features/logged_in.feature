Feature: I can log into Redmine and view user and plugin lists

  Background:
      Given user is at Redmine
      When user clicks Redmine Sign in link
      And user is redirected to authentication
      And user fills in valid username and valid password
      And user clicks login button
      Then user is redirected to Redmine as a logged in user

  @ViewInstalledPlugins
  Scenario: I can view installed plugins
      Given user is at Redmine
      When user clicks Redmine administration link
      And user clicks plugins link
      Then user is redirected to Plugin page

  @ViewUserList
  Scenario: I can view the user list
      Given user is at Redmine
      When user clicks Redmine administration link
      And user clicks users link
      Then user is directed to user page
      And user can see a valid user page
