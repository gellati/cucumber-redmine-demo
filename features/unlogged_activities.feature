Feature: I can interact with the site as an unlogged user

@ClickForgotPasswordLink
Scenario: As a user I can get to the password restore page
    Given user is at Redmine
    When user clicks Redmine Sign in link
    And user is redirected to authentication
    And user clicks forgot password link
    Then user is directed into password restore page

@RestorePasswordWithUnknownEmail
Scenario: As an user I cannot restore my forgotten password with unknown e-mail
    Given user is at the password restore page
    When user fills in email field with "abd@abc.fi"
    And user clicks submit button
    Then page contains text that no valid login detail is found with given address

@LogIntoRedmine
Scenario: I can log into Redmine
    Given user is at Redmine
    When user clicks Redmine Sign in link
    And user is redirected to authentication
    And user fills in valid username and valid password
    And user clicks login button
    Then user is redirected to Redmine as a logged in user
