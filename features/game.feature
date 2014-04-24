Feature: Play 2048
  Scenario: Start a new game
    When I start a new game
    Then the board has two random numbers
