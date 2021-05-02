### Q1 For every situation where student A likes student B, but student B likes a different student C, return the names and grades of A, B, and C.
select h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
from Highschooler h1, Highschooler h2, Highschooler h3, Likes l1, Likes l2
where h1.ID = l1.ID1 and h2.ID = l1.ID2 and h2.ID = l2.ID1 and h3.ID = l2.ID2 
and h1.ID != h2.ID and h1.ID != h3.ID and h2.ID != h3.ID;


### Q2 Find those students for whom all of their friends are in different grades from themselves. Return the students' names and grades.
select distinct h1.name, h1.grade
from Highschooler h1, Highschooler h2, Friend f
where h1.ID = f.ID1 and h2.ID = f.ID2 
and h1.ID not in (select h1.ID from Highschooler h1, Highschooler h2, Friend f
where h1.ID = f.ID1 and h2.ID = f.ID2 and h1.grade = h2.grade);


### Q3 What is the average number of friends per student? (Your result should be just one number.)
select avg(fn)
from (select count(ID2) as fn from Friend group by ID1);


### Q4 Find the number of students who are either friends with Cassandra or are friends of friends of Cassandra. Do not count Cassandra, even though technically she is a friend of a friend.
select count(distinct h1.name)+ count(distinct h3.name)-1
from Highschooler h1, Friend f, Highschooler h2, Highschooler h3, Friend f2
where h1.ID = f.ID1 and f.ID2 = h2.ID and h2.name = 'Cassandra' 
and h1.ID = f2.ID1 and f2.ID2 = h3.ID;


### Q5 Find the name and grade of the student(s) with the greatest number of friends.
select h.name, h.grade
from (select ID1, count(ID2) as fn from Friend group by ID1)as fnt, Highschooler h
where fnt.ID1 = h.ID 
and fnt.fn in (select max (fn) 
from (select ID1, count(ID2) as fn from Friend group by ID1));








