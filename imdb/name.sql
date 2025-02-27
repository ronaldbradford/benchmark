SELECT * FROM name WHERE name = ?;
SELECT t.title, t.start_year, tp.category FROM name n JOIN title_principal tp ON n.nconst = tp.nconst JOIN title t ON tp.tconst = t.tconst WHERE n.name = ? AND   t.type = 'movie' ORDER BY t.start_year DESC;
SELECT np.profession FROM name n JOIN name_profession np ON n.name_id = np.name_id WHERE n.name = ?;
SELECT np.profession, COUNT(*) as appearances FROM name n JOIN name_profession np ON n.name_id = np.name_id WHERE n.name = ? GROUP BY np.profession ORDER BY 2 desc;
SELECT t.title, t.start_year FROM name n JOIN title_director td ON n.nconst = td.nconst JOIN title t ON td.title_id = t.title_id WHERE n.name = ? AND   t.type = 'movie' ORDER BY t.start_year DESC;
SELECT t.title, r.average_rating, r.num_votes FROM name n JOIN title_principal tp ON n.nconst = tp.nconst JOIN title t ON tp.tconst = t.tconst JOIN title_rating r ON t.tconst = r.tconst WHERE n.name = ? AND tp.category IN ('actor', 'actress') AND   t.type = 'movie' ORDER BY r.average_rating DESC LIMIT 10;
SELECT n.name, cn.name AS character_name, t.title AS movie, t.start_year FROM name n JOIN title_character tc ON n.name_id = tc.name_id JOIN character_name cn ON tc.character_id = cn.character_id JOIN title t ON tc.title_id = t.title_id WHERE n.name = ? AND   t.type = 'movie' ORDER BY t.start_year DESC;
SELECT t.title, t.start_year FROM name n JOIN title_principal tp ON n.nconst = tp.nconst JOIN title t ON tp.tconst = t.tconst WHERE n.name = ? ORDER BY t.start_year DESC LIMIT 1;
