### Q1 Find the names of all students who are friends with someone named Gabriel.
select h1.name
from (Highschooler h1 join Friend f on h1.ID = f.ID1) join Highschooler h2 on h2.ID = f.ID2
where h2.name = 'Gabriel';


### Q2 For every student who likes someone 2 or more grades younger than themselves, return that student's name and grade, and the name and grade of the student they like.
select h1.name, h1.grade, h2.name, h2.grade
from (Highschooler h1 join Likes l on h1.ID = l.ID1) join Highschooler h2 on h2.ID = l.ID2
where h1.grade - h2.grade >=2;


### Q3 For every pair of students who both like each other, return the name and grade of both students. Include each pair only once, with the two names in alphabetical order.
select h1.name, h1.grade, h2.name, h2.grade
from Likes l1, Likes l2, Highschooler h1, Highschooler h2
where (h1.ID = l1.ID1 and h2.ID = l1.ID2) and (h2.ID = l2.ID1 and h1.ID = l2.ID2) and h1.name < h2.name
order by 1,3;


### Q4 Find all students who do not appear in the Likes table (as a student who likes or is liked) and return their names and grades. Sort by grade, then by name within each grade.
select name, grade
from Highschooler
where ID not in (select ID1 from Likes) and ID not in (select ID2 from Likes);


### Q5 For every situation where student A likes student B, but we have no information about whom B likes (that is, B does not appear as an ID1 in the Likes table), return A and B's names and grades.
select h1.name, h1.grade, h2.name, h2.grade
from Highschooler h1, Highschooler h2, Likes l
where (h1.ID = l.ID1 and h2.ID = l.ID2) and h2.ID not in (select ID1 from Likes);


### Q6 Find names and grades of students who only have friends in the same grade. Return the result sorted by grade, then by name within each grade.
select name, grade
from Highschooler
where ID not in (select h1.ID
				 from (Highschooler h1 join Friend f on h1.ID = f.ID1) join Highschooler h2 on f.ID2 = h2.ID
				 where h1.grade != h2.grade)
order by 2,1;


### Q7 For each student A who likes a student B where the two are not friends, find if they have a friend C in common (who can introduce them!). For all such trios, return the name and grade of A, B, and C.
select h1.name, h1.grade, h2.name, h2.grade, h3.name, h3.grade
from Highschooler h1, Highschooler h2, Highschooler h3, Likes l, Friend f1, Friend f2
where (h1.ID = l.ID1 and h2.ID = l.ID2) and (h1.ID = f1.ID1 and h3.ID = f1.ID2) and (h2.ID = f2.ID1 and h3.ID = f2.ID2)
and h2.ID not in (select ID2 from Friend f where h1.ID = f.ID1);


### Q8 Find the difference between the number of students in the school and the number of different first names.
select count(ID) - count(distinct name)
from Highschooler;


### Q9 Find the name and grade of all students who are liked by more than one other student.
select h.name, h.grade
from Highschooler h
where h.ID in 
(select ID2 from Likes where ID2 != ID1 group by ID2 having count(ID2)>1);










