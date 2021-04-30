### Q1 Find the names of all reviewers who rated Gone with the Wind.
select distinct rv.name
from (Reviewer rv join Rating r on rv.rID = r.rID) join Movie m on r.mID = m.mID
where m.title = 'Gone with the Wind';


### Q2 For any rating where the reviewer is the same as the director of the movie, return the reviewer name, movie title, and number of stars.
select rv.name, m.title, r.stars
from (Reviewer rv join Rating r on rv.rID = r.rID) join Movie m on r.mID = m.mID
where rv.name = m.director;


### Q3 Return all reviewer names and movie names together in a single list, alphabetized. 
###(Sorting by the first name of the reviewer and first word in the title is fine; no need for special processing on last names or removing "The".)
select name from Reviewer
union
select title from Movie;


### Q4 Find the titles of all movies not reviewed by Chris Jackson.
select m.title
from Movie m
where m.mID not in (select m.mID 
				 from (Reviewer rv join Rating r on rv.rID = r.rID) join Movie m on r.mID = m.mID
				 where rv.name = 'Chris Jackson');


### Q5 For all pairs of reviewers such that both reviewers gave a rating to the same movie, return the names of both reviewers. 
###Eliminate duplicates, don't pair reviewers with themselves, and include each pair only once. For each pair, return the names in the pair in alphabetical order.
select distinct p1.name, p2.name
from (Rating r join Reviewer rv on r.rID = rv.rID) p1 
join (Rating r join Reviewer rv on r.rID = rv.rID) p2 using(mID)
where p1.name < p2.name
order by 1;


### Q6 For each rating that is the lowest (fewest stars) currently in the database, return the reviewer name, movie title, and number of stars.
select rv.name, m.title, r.stars
from (Reviewer rv join Rating r on rv.rID = r.rID) join Movie m on r.mID = m.mID
where r.stars <= (select stars from Rating);


### Q7 List movie titles and average ratings, from highest-rated to lowest-rated. If two or more movies have the same average rating, list them in alphabetical order.
select m.title, avg(r.stars)
from Movie m join Rating r on m.mID = r.mID
group by 1
order by 2 desc, 1;


### Q8 Find the names of all reviewers who have contributed three or more ratings. (As an extra challenge, try writing the query without HAVING or without COUNT.)
select distinct name
from (Reviewer rv join Rating r on rv.rID = r.rID) t1
where (select count(*) 
	   from (Reviewer rv join Rating r on rv.rID = r.rID) t2
	   where t1.rID = t2.rID) >=3;



### Q9 Some directors directed more than one movie. For all such directors, return the titles of all movies directed by them, along with the director name. Sort by director name, then movie title. 
###(As an extra challenge, try writing the query both with and without COUNT.)

###With COUNT()
select title, director
from Movie
where director in (select director from Movie group by 1 having count(*)>1)
order by 2,1; 

###without count()
select title, director
from Movie
where director in (select director from Movie group by 1 having max(mID)>min(mID))
order by 2,1; 


### Q10 Find the movie(s) with the highest average rating. Return the movie title(s) and average rating. 
###(Hint: This query is more difficult to write in SQLite than other systems; you might think of it as finding the highest average rating and then choosing the movie(s) with that average rating.)
select ma.title, max(ma.avg1)
from (select m.title, avg(r.stars) as avg1
	  from Movie m join Rating r on m.mID = r.mID 
	  group by 1) ma;


### Q11 Find the movie(s) with the lowest average rating. Return the movie title(s) and average rating. 
###(Hint: This query may be more difficult to write in SQLite than other systems; you might think of it as finding the lowest average rating and then choosing the movie(s) with that average rating.)
select *
from (select m.title, avg(r.stars) as avg1
	  from Movie m join Rating r on m.mID = r.mID 
	  group by 1)
where avg1 in (select min(avg1) 
			   from (select m.title, avg(r.stars) as avg1
					 from Movie m join Rating r on m.mID = r.mID 
					 group by 1));


### Q12 For each director, return the director's name together with the title(s) of the movie(s) they directed that received the highest rating among all of their movies, and the value of that rating. Ignore movies whose director is NULL.
select distinct m.director, m.title, m.stars
from (Movie join Rating using(mID)) m
where m.stars in (select max(stars) 
				from Movie join Rating using(mID)
				where m.director = director)
order by 1;





