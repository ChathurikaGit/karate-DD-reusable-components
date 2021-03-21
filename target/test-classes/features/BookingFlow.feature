Feature: Search and Book

  @BOOKING_FLOW
  Scenario Outline: Search for the particular hotel and book it

  Given def SearchCall = call read('classpath:data/reusableComponents/Search.feature'){ date_check_in: date_check_in ,date_check_out: date_check_out ,adults_count: adults_count, children_count: children_count ,infants_count:infants_count }

    #Taken data from search response
    * def room_type_code = SearchCall.response.availablity_price[0].room_type_code
    * def rate_plan_code = SearchCall.response.availablity_price[0].available_plans[0].rate_plan_code

    * print room_type_code
    * print rate_plan_code

    ############################## Assertions Task 02.3 ####################################################
    #Check success status
    Then match SearchCall.response.success == true

    #Verifing first room type under "availablity_price" json array is “K1DAA”
    Then match SearchCall.response.availablity_price[0].room_type_code == "K1DAA"

    #Verifing rate plan code of the first available_plan of K1DAA room type is “DAPR”
    Then match SearchCall.response.availablity_price[0].available_plans[0].rate_plan_code == "DAPR"

    #Verifing total_amount_after_tax is greater than total_amount_before_tax
    Then assert SearchCall.response.availablity_price[0].available_plans[0].total_amount_before_tax < SearchCall.response.availablity_price[0].available_plans[0].total_amount_after_tax


  Given def BookCall = call read('classpath:data/reusableComponents/Book.feature')

    ############################## Assertions Task 02.4 ####################################################
    #Verifing confirmation code is not null
    Then match BookCall.response.confirmation[0].confirmation_code == '#notnull'

    #Verifing whether the room type and rate plan are correct
    Then match BookCall.response.confirmation[0].room_type_code == room_type_code
    #Then match BookCall.response.confirmation[0].rate_plan_code == rate_plan_code

    #Verifing the pax counts
    Then match BookCall.response.confirmation[0].adults_count == '#(parseInt(adults_count))'
    Then match BookCall.response.confirmation[0].children_count == '#(parseInt(children_count))'
    Then match BookCall.response.confirmation[0].infants_count == '#(parseInt(infants_count))'




  Examples:
  | read('classpath:data/csv/data.csv') |