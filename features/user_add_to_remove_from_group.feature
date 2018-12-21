@AddRemoveUserGroup
Feature: I can add users to a group and remove them from a group

Background:
  Given user is at Redmine
  When user clicks Redmine Sign in link
  And user is redirected to authentication
  And user fills in valid username and valid password
  And user clicks login button
  And user is redirected to Redmine as a logged in user
  And user is at user page
  And user clicks New user button
  And user is redirected to New user page
  And user creates new user
  And user can see a new user has been created
  And user is at user page
  And user clicks groups link
  And user is redirected to Groups page
  And user clicks New group link
  And user is redirected to New group page
  And user creates a new group
  Then user should be redirected to Groups page
  And page should contain the new group name

Scenario: I can add a user to a group
  Given user is at user page
  When user clicks groups link
  And user is redirected to Groups page
  And user adds a new user to the group
  Then group table contains the new user


Scenario: I can remove a user from a group
  Given user is at user page
  When user clicks groups link
  And user is redirected to Groups page
  And user deletes a user from the group
  Then the group member page should not contain the user

Scenario: I can clean up by removing the test user and the test group
  Given user is at user page
  When user deletes a user from the users page
  Then users page should not contain the user
  Given user is at user page
  When user clicks groups link
  And user is redirected to Groups page
  And user deletes a group from the Groups page
  Then the Groups page should not contain the group
