Feature: account management

  As a superuser
  So that I can manage the mentor accounts
  I want to view the list of all mentors, create a new mentor, edit mentor info, and destroy a mentor account

  Background: mentors and schools have been added to database, signed in as a super_user

    Given the following schools exist:
      | Berkeley Arts Magnet School     | 2015 Virginia St, Berkeley, CA 94709  | 37.876869  | -122.270348   |
      | Jefferson Elementary School     | 1400 Ada St, Berkeley, CA 94702       | 37.878910  | -122.284420   |

    And the following mentors exist:
      | Emma Sandoval     | es@berkeley.edu | Berkeley Arts Magnet School  |
      | Kyler Ochoa       | ko@berkeley.edu | Jefferson Elementary School  |
      | Joseph Gonzalez   | jg@berkeley.edu | Jefferson Elementary School  |

    And the following checkins exist:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-1 13:00:00  | 37.876869 | -122.270348 | true |

    And the following checkouts exist:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-1 14:00:00  | 37.876869 | -122.270348 | true |

    Given I am signed in as a "superuser"
    And I am on the "account_management" page with the "mentors" tab active

  Scenario: view the list of all mentors
    Then I should see the the following table row :
      | Emma Sandoval | es@berkeley.edu | Berkeley Arts Magnet School |
    And I should see the the following table row :
      | Kyler Ochoa | ko@berkeley.edu | Jefferson Elementary School |
    And I should see the the following table row :
      | Joseph Gonzalez | jg@berkeley.edu | Jefferson Elementary School |

  Scenario: create a new mentor
    When I press the “New Mentor” link
    Then I should be redirected to the "new_mentor" page
    And I type in "testMentor" in the input box labeled "Name"
    And I type in "testMentor@berkeley.edu" in the input box labeled "Email"
    And I choose "Berkeley Arts Magnet School" in the select box labeled "Select School"
    And I press the “Save” button
    Then I should have this "mentor" record:
      | testMentor | testMentor@berkeley.edu | Berkeley Arts Magnet School |

  Scenario: edit mentor info
    When I press the “Edit” link on the record row of "Emma Sandoval"
    Then I should be redirected to the "edit_mentor(Emma Sandoval)" page
    And I type in "Emma Sandoval2" in the input box labeled "Name"
    And I press the “Save” button
    Then I should have this "mentor" record:
      | Emma Sandoval2 | es@berkeley.edu | Berkeley Arts Magnet School |

  Scenario: destroy a mentor account and all related checkins and checkouts should also be deleted
    When I press the “Destroy” link on the record row of "Emma Sandoval"
    And a "Are you sure ..." confirmation message poped up
    And I press "OK"
    Then I should no longer have this "mentor" record:
      | Emma Sandoval     | es@berkeley.edu | Berkeley Arts Magnet School  |
    Then I should no longer have this "checkin" record:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-1 13:00:00  | 37.876869 | -122.270348 | true |
    Then I should no longer have this "checkout" record:
      | Emma Sandoval     | Berkeley Arts Magnet School | 2019-12-1 14:00:00  | 37.876869 | -122.270348 | true |

