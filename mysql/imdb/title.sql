SELECT t.* FROM title t WHERE t.title = ?  AND t.type = 'movie';
SELECT g.genre FROM title_genre g JOIN title t ON g.title_id = t.title_id WHERE t.title = ?  AND t.type = 'movie';
SELECT t.title, r.average_rating, r.num_votes FROM title t JOIN title_rating r ON t.title_id = r.title_id WHERE t.title = ?  AND t.type = 'movie';
SELECT n.name AS name, tnc.character_name FROM name n JOIN title_name_character tnc ON n.name_id = tnc.name_id JOIN title t ON t.title_id = tnc.title_id WHERE t.title = ?  AND t.type = 'movie';
SELECT n.name, tp.category FROM title_principal tp JOIN title t ON t.title_id = tp.title_id JOIN name n ON n.name_id = tp.name_id WHERE t.title = ? AND t.type = 'movie';
