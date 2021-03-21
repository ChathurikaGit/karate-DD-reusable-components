Feature: Booked the searched hotel

  Scenario: POST component

    Given url mainUrl
    Given path 'hotels/book/v1/JAQ/reservations'

    * def postRequest = read('classpath:data/json/BookRQ.json')

    * set postRequest.req_rooms[0].adults_count = adults_count
    * set postRequest.req_rooms[0].children_count = children_count
    * set postRequest.req_rooms[0].infants_count = infants_count
    * set postRequest.date_check_in = date_check_in
    * set postRequest.date_check_out = date_check_out
    * set postRequest.req_rooms[0].room_type_code = room_type_code
    * set postRequest.req_rooms[0].rate_plan_code = rate_plan_code

    When request postRequest
    When method POST
    Then status 200

    * print response