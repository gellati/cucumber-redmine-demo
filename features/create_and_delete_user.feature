@CreateAndDeleteUser
Feature: I can create and delete users

Background:
  Given user is at Redmine
  When user clicks Redmine Sign in link
  And user is redirected to authentication
  And user fills in valid username and valid password
  And user clicks login button
  Then user is redirected to Redmine as a logged in user

  @CreateUser
  Scenario: I can add a new user
     Given user is at user page
     When user clicks New user button
     And user is redirected to New user page
     And user creates new user
     Then user can see a new user has been created


  @DeleteUser
  Scenario: I can delete a user
     Given user is at user page
     When user deletes a user from the users page
     Then users page should not contain the user
