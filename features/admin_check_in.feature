Feature: admin check-in

  As an administrator
  So that I can check the attendance of the mentors of my school
  I want to check in to my administrator account

  Background: admins and mentors have been added to database

    Given the following mentors exist:
      | mike ball     | mb@berkeley.edu | emerson elementary  |
      | jeremy warner | jw@berkeley.edu | emerson elementary  |
      | cho chang     | cc@hogwarts.edu | berkeley elementary |
      | percy weasley | pw@hogwarts.edu | berkeley elementary |

    And the following admins exist:
      | jane doe     | emerson@sagementorship.org  | emerson elementary  |
      | jim le       | berkeley@sagementorship.org | berkeley elementary |
      | taylor smith | cooper@gmail.com            | cooper elementary   |

    And I am on the check-in page

  Scenario: check-in successfully
    Given I press the “sign-in with gmail” button
    And I successfully sign-in through gmail
    Then I should be redirected to the AdminView page for my school

  Scenario: fail to check in with wrong password
    Given I press the “sign-in with gmail” button
    And I attempt to sign-in with an email account that is associated with an admin
    And I use the wrong password
    Then I should be redirected to the check in page
    And I should see a flash warning at the top of the page that states “Login failed. Invalid admin credentials”
    And my check in attempt should not be found in the database

  Scenario: fail to check in with email that is not associated with an admin
    Given I am on the AdminCheckIn page
    And I press the “sign-in with gmail” button
    And I attempt to sign-in with an email account that is not associated with an admin
    Then I should be redirected to the check in page
    And I should see a flash warning at the top of the page that states “Login failed. Invalid admin credentials”

