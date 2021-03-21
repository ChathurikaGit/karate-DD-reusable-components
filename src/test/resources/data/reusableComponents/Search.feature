Feature: Search for the hotel

  Scenario: Search for the hotel with the room type code “K1DAA” and rate plan code “DAPR”

    Given url mainUrl
    Given path 'hotels/book/v1/JAQ/availability'

    Given param date_check_in = date_check_in
    And param date_check_out = date_check_out
    And param adults_count = adults_count
    And param children_count = children_count
    And param infants_count = infants_count

    When method GET
    Then status 200

