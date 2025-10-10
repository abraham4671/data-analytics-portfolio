create database movies;
use movies;
# Top 5 Highest-Grossing Movies
SELECT title, revenue
FROM movies
ORDER BY revenue DESC
LIMIT 5;
# Average IMDb Rating by Genre
SELECT genres, AVG(vote_average) AS avg_rating
FROM movies
GROUP BY genres
ORDER BY avg_rating DESC;
# Movies with Profit > 100 Million
SELECT title, Profit
FROM movies
WHERE Profit > 100000000;

