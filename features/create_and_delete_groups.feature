@CreateAndDeleteGroup
Feature: I can create and delete groups

Background:
  Given user is at Redmine
  When user clicks Redmine Sign in link
  And user is redirected to authentication
  And user fills in valid username and valid password
  And user clicks login button
  Then user is redirected to Redmine as a logged in user


Scenario: I can create a group
    Given user is at user page
    When user clicks groups link
    And user is redirected to Groups page
    And user clicks New group link
    And user is redirected to New group page
    And user creates a new group
    Then user should be redirected to Groups page
    And page should contain the new group name

Scenario: I can delete a group
    Given user is at user page
    When user clicks groups link
    And user is redirected to Groups page
    And user deletes a group from the Groups page
    Then the Groups page should not contain the group
