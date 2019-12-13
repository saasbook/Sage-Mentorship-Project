Feature: account management

  As a superuser
  So that I can manage the mentor accounts
  I want to view the list of all mentors, create a new mentor, edit mentor info, and destroy a mentor account

  Background: mentors and schools have been added to database, signed in as a super_user


    Given the following schools exist:
      | name                            | address                               | lat        | lon           |
      | Berkeley Arts Magnet School     | 2015 Virginia St, Berkeley, CA 94709  | 37.876869  | -122.270348   |
      | Jefferson Elementary School     | 1400 Ada St, Berkeley, CA 94702       | 37.878910  | -122.284420   |

    And the following supers exist:
      | name       | email                       |
      | Jasamine   | jasamine@sagementorship.org |

    And the following admins exist:
      | name       | email                      | school_id                    |
      | Darain     | darain@sagementorship.org  | Berkeley Arts Magnet School  |

    And the following mentors exist:
      | name      | email             | school_id                    |
      | Emma AZ    | esAZ@berkeley.edu | Berkeley Arts Magnet School  |
      | Kyler     | ko@berkeley.edu | Jefferson Elementary School  |
      | Joseph    | jg@berkeley.edu | Jefferson Elementary School  |


    And the following checkins exist:
      | mentor_id | school_id                   | checkin_time       | checkin_lat| checkin_lon  | isValid |
      | Kyler    | Jefferson Elementary School | 2019-12-1 13:00:00 | 37.876869  | -122.270348  | true    |

    And the following checkouts exist:
      | mentor_id | school_id                   | checkout_time      |checkout_lat|checkout_lon  | isValid |
      | Kyler    | Jefferson Elementary School | 2019-12-1 14:00:00 |37.876869   | -122.270348  | true    |

    Given I am signed in as an "super", "Jasamine"
    And I am on the "mentors_index" page


  Scenario: 1) view the list of all mentors
    Then I should see the the following table row :
      | Name    | Email           | School                      |
      | Emma AZ    | esaz@berkeley.edu | Berkeley Arts Magnet School  |
      | Kyler     | ko@berkeley.edu | Jefferson Elementary School  |
      | Joseph    | jg@berkeley.edu | Jefferson Elementary School  |


  Scenario: 2) create a new mentor
    When I press the "New Mentor" link
    Then I should be redirected to the "new_mentor" page
    And I type in "testMentor" in the input box labeled "Name"
    And I type in "testmentor@berkeley.edu" in the input box labeled "Email"
    And I choose "Berkeley Arts Magnet School" in the select box labeled "School"
    And I press the "Save" button
    Then I should have this "mentor" record:
      | name        | email                   | school_id                   |
      | testMentor  | testmentor@berkeley.edu | Berkeley Arts Magnet School |

  Scenario: 3) edit mentor info
    Given I am on the "edit_mentor, Emma AZ" page
    And I type in "Emily" in the input box labeled "Name"
    And I press the "Save" button
    Then I should have this "mentor" record:
      | name   | email           | school_id                   |
      | Emily  | esAZ@berkeley.edu | Berkeley Arts Magnet School |


  Scenario: 4) destroy a mentor account and all related checkins and checkouts should also be deleted
    Given I delete this "mentor" record:
      | name      | email           | school_id                    |
      | Kyler   | ko@berkeley.edu | Jefferson Elementary School  |
    Then I should no longer have this "mentor" record:
      | name      | email           | school_id                    |
      | Kyler   | ko@berkeley.edu | Jefferson Elementary School  |
    Then I should no longer have this "checkin" record:
      | mentor_id | school_id                   | checkin_time        | checkin_lat| checkin_lon  | isValid |
      | Kyler    | Jefferson Elementary School | 2019-12-1 13:00:00 | 37.876869  | -122.270348  | true    |
    Then I should no longer have this "checkout" record:
      | mentor_id | school_id                   | checkout_time       |checkout_lat|checkout_lon  | isValid |
      | Kyler    | Jefferson Elementary School | 2019-12-1 14:00:00 |37.876869   | -122.270348  | true    |

