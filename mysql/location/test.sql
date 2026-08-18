SELECT * FROM city WHERE name = ?;
SELECT * FROM place WHERE name->>'$.address.city' = ?;
