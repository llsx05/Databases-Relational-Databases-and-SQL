### Q1 It's time for the seniors to graduate. Remove all 12th graders from Highschooler.
delete from Highschooler
where grade = 12;


### Q2 If two students A and B are friends, and A likes B but not vice-versa, remove the Likes tuple.
delete from Likes
where ID1 in (select l.ID1 from Friend f join Likes l using(ID1) 
	where f.ID2 = l.ID2)
and ID2 not in (select l.ID1 from Friend f join Likes l using(ID1) 
	where f.ID2 = l.ID2);


### Q3 For all cases where A is friends with B, and B is friends with C, add a new friendship for the pair A and C. Do not add duplicate friendships, friendships that already exist, or friendships with oneself. (This one is a bit challenging; congratulations if you get it right.)
insert into Friend 
select distinct f1.ID1, f2.ID2
from Friend f1, Friend f2
where f1.ID2 = f2.ID1 and f1.ID1 != f2.ID2 
and f1.ID1 not in (select f3.ID1 from Friend f3 where f2.ID2 = f3.ID2);