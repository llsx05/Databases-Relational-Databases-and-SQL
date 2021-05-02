### Q1 Add the reviewer Roger Ebert to your database, with an rID of 209.
insert into Reviewer values (209, 'Roger Ebert');


### Q2 For all movies that have an average rating of 4 stars or higher, add 25 to the release year. (Update the existing tuples; don't insert new tuples.)
update Movie
set year = year + 25
where mID in (select m.mID from Movie m join Rating r using(mID) 
group by m.title having avg(r.stars) >=4);


### Q3 Remove all ratings where the movie's year is before 1970 or after 2000, and the rating is fewer than 4 stars.
delete from Rating
where mID in (select m.mID from Movie m join Rating r using(mID)
			  where m.year < 1970 or m.year > 2000) and stars < 4;





