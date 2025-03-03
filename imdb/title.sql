SELECT * FROM title t WHERE t.title = ? AND t.type = 'movie';
SELECT t.title, r.average_rating, r.num_votes FROM title t JOIN title_rating r USING (title_id) WHERE t.title = ? AND t.type = 'movie';
SELECT g.genre FROM title_genre g JOIN title t USING (title_id) WHERE t.title = ? AND t.type = 'movie';
SELECT DISTINCT n.name AS name, tnc.character_name FROM name n JOIN title_name_character tnc USING (name_id) JOIN title t USING (title_id) WHERE t.title = ? AND t.type = 'movie';


