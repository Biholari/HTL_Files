-- SYNTAX
IIF(boolean_expression, true_value, false_value) 

-- Example 1
SELECT IIF(NULL IS NULL, 'Yes', 'No') AS Result;
SELECT IIF(50 = NULL, 'Yes', 'No') AS Result;


-- Example 2
SELECT lnr, lname, rabatt, stadt,
    IIF(rabatt > 15, 'Yes', 'No') AS discounted
FROM l;