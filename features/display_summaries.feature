Feature: display_summaries

  As a admin
  So that I can monitor the attendance of the mentors assigned to my school
  I want to view the school activities, weeks summaries and the attendances list of a mentor for a specific week


Background: mentors and schools have been added to database, signed in as a admin

    Given the following schools exist:
      | name                            | address                               | lat        | lon           |
      | Berkeley Arts Magnet School     | 2015 Virginia St, Berkeley, CA 94709  | 37.876869  | -122.270348   |

    And the following admins exist:
      | name       | email                      | school_id                    |
      | Darain     | darain@sagementorship.org  | Berkeley Arts Magnet School  |

    And the following mentors exist:
      | name      | email             | school_id                    |
      | Emma      | emma@berkeley.edu | Berkeley Arts Magnet School  |
      | Kyler     | ko@berkeley.edu   | Berkeley Arts Magnet School  |
      | Joseph    | jg@berkeley.edu   | Berkeley Arts Magnet School  |

    And the following checkins exist:
      | mentor_id | school_id                   | checkin_time       | checkin_lat| checkin_lon  | isValid |
      | Joseph    | Berkeley Arts Magnet School | 2019-12-2 13:00:00 | 30         | -120         | false   |
      | Joseph    | Berkeley Arts Magnet School | 2019-12-3 9:00:00  | 37.876869  | -122.270348  | true    |

    And the following checkouts exist:
      | mentor_id | school_id                   | checkout_time      |checkout_lat|checkout_lon  | isValid |
      | Joseph    | Berkeley Arts Magnet School | 2019-12-2 14:00:00 | 30         | -120         | false   |
      | Joseph    | Berkeley Arts Magnet School | 2019-12-3 10:00:00 | 37.876869  | -122.270348  | true    |

    And the following checkins exist:
      | mentor_id | school_id                   | checkin_time       |checkin_lat| checkin_lon | isValid |
      | Emma      | Berkeley Arts Magnet School | 2019-12-2 13:00:00 | 37.876869 | -122.270348 | true    |
      | Emma      | Berkeley Arts Magnet School | 2019-12-3 9:00:00  | 37.876869 | -122.270348 | true    |
      | Emma      | Berkeley Arts Magnet School | 2019-12-4 9:00:00  | 37.876869 | -122.270348 | true    |

    And the following checkouts exist:
      | mentor_id | school_id                   | checkout_time       |checkout_lat|checkout_lon | isValid |
      | Emma      | Berkeley Arts Magnet School | 2019-12-3 10:00:00  | 37.876869  | -122.270348 | true    |
      | Emma      | Berkeley Arts Magnet School | 2019-12-4 10:00:00  | 37.876869  | -122.270348 | true    |

    And the following checkins exist:
      | mentor_id | school_id                   | checkin_time         |checkin_lat| checkin_lon | isValid |
      | Kyler     | Berkeley Arts Magnet School | 2019-11-18 13:00:00  | 37.876869 | -122.270348 | true    |

    And the following checkouts exist:
      | mentor_id | school_id                   | checkout_time        |checkout_lat| checkout_lon | isValid |
      | Kyler     | Berkeley Arts Magnet School | 2019-11-18 14:30:00  | 37.876869  | -122.270348  | true    |

    And I am signed in as an admin "Darain"



Scenario: 1) the mentor checkined with invalid geolocation

  Given I am on the "schools" page and I pass "Berkeley Arts Magnet School" as school and "12/02/2019" date
  Then I should see the the following table row :
    | Mentor | Week Hours | Any Missed Checkout? | Any Invalid Geoloc? | Accumulated Hours |
    | Joseph | 1          | -                    | Yes                 | 1                 |

  Given I am on the "weeks_summary" page and pass "Joseph" as mentor
  Then I should see the the following table row :
    | Week of    | School                       | Total Hours | Any Missed Checkout? | Any Invalid Geoloc? |
    | 12/02/2019 | Berkeley Arts Magnet School  | 1           | -                    | Yes                 |



Scenario: 2) the mentor forgot to checkout in one of the attendances this week

  Given I am on the "schools" page and I pass "Berkeley Arts Magnet School" as school and "12/02/2019" date
  Then I should see the the following table row :
    | Mentor | Week Hours | Any Missed Checkout? | Any Invalid Geoloc? | Accumulated Hours |
    | Emma   | 2          | Yes                  | -                   | 2                 |

  Given I am on the "weeks_summary" page and pass "Emma" as mentor
  Then I should see the the following table row :
    | Week of    | School                       | Total Hours | Any Missed Checkout? | Any Invalid Geoloc? |
    | 12/02/2019 | Berkeley Arts Magnet School  | 2           | Yes                  | -                   |



Scenario: 3) the mentor did not check-in this week

  Given I am on the "schools" page and I pass "Berkeley Arts Magnet School" as school and "12/02/2019" date
  Then I should see the the following table row :
    | Mentor | Week Hours | Any Missed Checkout? | Any Invalid Geoloc? | Accumulated Hours |
    | Kyler  | 0          | -                    | -                   | 1.5               |

  Given I am on the "weeks_summary" page and pass "Kyler" as mentor
  Then I should see the the following table row :
    | Week of    | School                       | Total Hours | Any Missed Checkout? | Any Invalid Geoloc? |
    | 12/02/2019 |                              | 0           | -                    | -                   |
    | 11/18/2019 | Berkeley Arts Magnet School  | 1.5         | -                    | -                   |

  Given I am on the "attendances" page and pass "Kyler" as mentor and "11/18/2019" as date
  Then I should see the the following table row :
    |Date      |Hours|School                     |Checkin Time|Checkin Location        |Checkin Invalid Geoloc|Checkout Time|Checkout Location       |Checkout Invalid Geoloc|
    |11/18/2019|1.5  |Berkeley Arts Magnet School|13:00:00    |(37.876869, -122.270348)|-                     |14:30:00     |(37.876869, -122.270348)|-                      |

