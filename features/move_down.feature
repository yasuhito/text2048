Feature: Move down
  Scenario: Move empty board
    Given a board:
    """
    _ _ _ _
    _ _ _ _
    _ _ _ _
    _ _ _ _
    """
    When I move the board down
    Then the board is:
    """
    _ _ _ _
    _ _ _ _
    _ _ _ _
    _ _ _ _
    """
    And the score is 0

  Scenario: Move numbers
    Given a board:
    """
    2 _ _ _
    _ 2 _ _
    _ _ 2 _
    _ _ _ 2
    """
    When I move the board down
    Then the board is:
    """
    _ _ _ _
    _ _ _ _
    _ _ _ _
    2 2 2 2
    """
    And the score is 0

  Scenario: Merge numbers
    Given a board:
    """
    2 _ _ _
    _ 2 2 _
    2 _ _ 2
    _ _ 2 _
    """
    When I move the board down
    Then the board is:
    """
    _ _ _ _
    _ _ _ _
    _ _ _ _
    4 2 4 2
    """
    And the score is 8

  Scenario: Move and merge mix of numbers
    Given a board:
    """
    2 _ _ 2
    _ 2 4 _
    4 _ _ _
    _ _ 2 2
    """
    When I move the board down
    Then the board is:
    """
    _ _ _ _
    _ _ _ _
    2 _ 4 _
    4 2 2 4
    """
    And the score is 4
