--Q1: Find the titles of all movies directed by Steven Spielberg
select title
from Movie
where director = 'Steven Spielberg';


--Q2: Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.
select distinct m.year
from movie m, rating r
where m.mID = r.mID and r.stars >=4
order by m.year asc;


--Q3: Find the titles of all movies that have no ratings.
select distinct m.title
from Movie m, Rating r
where m.mID not in (select m.mID from Movie m, Rating r where m.mID = r.mID);


--Q4: Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.
select rv.name
from Reviewer rv join Rating r on rv.rID = r.rID
where r.stars is not null and r.ratingDate is null;


--Q5: Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.
select rv.name as 'reviewer name', m.title as 'movie title', r.stars as stars, r.ratingDate as ratingDate
from (Reviewer rv join Rating r on rv.rID = r.rID) join Movie m on r.mID = m.mID
order by 1, 2, 3;


--Q6: For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.
select rv.name, m.title
from Rating r1, Rating r2, Movie m, Reviewer rv
where r1.rID = r2.rID and r1.mID = r2.mID and r1.mID = m.mID and rv.rID = r1.rID and r1.ratingDate > r2.ratingDate and r1.stars > r2.stars;


--Q7: For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.
select m.title, max(r.stars)
from Movie m join Rating r on m.mID = r.mID
group by m.title
having count(r.mID)>1
order by 1


--Q8: For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title.
select m.title, max(r.stars)-min(r.stars) as 'rating spread'
from Movie m join Rating r on m.mID = r.mID
group by 1
order by 2 desc, 1;


--Q9:Find the difference between the average rating of movies released before 1980 and the average rating of movies released after 1980. (Make sure to calculate the average rating for each movie, then the average of those averages for movies before 1980 and movies after. Don't just calculate the overall average rating before and after 1980.)
select abs(sum(ae1.avg_each)/count(ae1.title) - sum(ae2.avg_each)/count(ae2.title))
from (select m.title, avg(r.stars) as avg_each, m.year
	  from Movie m join Rating r on m.mID = r.mID
	  group by 1) ae1, 
	  (select m.title, avg(r.stars) as avg_each, m.year
	  from Movie m join Rating r on m.mID = r.mID
	  group by 1) ae2
where ae1.year <1980 and ae2.year >1980;















