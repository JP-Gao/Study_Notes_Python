#LyX 2.1 created this file. For more info see http://www.lyx.org/
\lyxformat 474
\begin_document
\begin_header
\textclass article
\begin_preamble
\usepackage[BoldFont,SlantFont,CJKnumber,fallback]{xeCJK}%使用TexLive自带的xeCJK宏包，并启用加粗、斜体、CJK数字和备用字体选项
\setCJKmainfont{Songti SC}%设置中文衬线字体,若没有该字体,请替换该字符串为系统已有的中文字体,下同
\setCJKsansfont{STXihei}%中文无衬线字体
\setCJKmonofont{SimHei}%中文等宽字体
%中文断行和弹性间距在XeCJK中自动处理了
%\XeTeXlinebreaklocale “zh”%中文断行
%\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt%左右弹性间距
\usepackage{indentfirst}%段落首行缩进
\setlength{\parindent}{2em}%缩进两个字符
\end_preamble
\use_default_options true
\maintain_unincluded_children false
\language english
\language_package auto
\inputencoding utf8-plain
\fontencoding global
\font_roman default
\font_sans default
\font_typewriter default
\font_math auto
\font_default_family default
\use_non_tex_fonts true
\font_sc false
\font_osf false
\font_sf_scale 100
\font_tt_scale 100
\graphics default
\default_output_format pdf4
\output_sync 0
\bibtex_command default
\index_command default
\paperfontsize default
\spacing single
\use_hyperref true
\pdf_bookmarks true
\pdf_bookmarksnumbered true
\pdf_bookmarksopen true
\pdf_bookmarksopenlevel 3
\pdf_breaklinks false
\pdf_pdfborder false
\pdf_colorlinks true
\pdf_backref section
\pdf_pdfusetitle true
\pdf_quoted_options "unicode=false"
\papersize default
\use_geometry true
\use_package amsmath 1
\use_package amssymb 1
\use_package cancel 0
\use_package esint 1
\use_package mathdots 1
\use_package mathtools 0
\use_package mhchem 1
\use_package stackrel 0
\use_package stmaryrd 0
\use_package undertilde 0
\cite_engine basic
\cite_engine_type default
\biblio_style plain
\use_bibtopic false
\use_indices false
\paperorientation portrait
\suppress_date false
\justification true
\use_refstyle 1
\index Index
\shortcut idx
\color #008000
\end_index
\leftmargin 2.5cm
\topmargin 2.5cm
\rightmargin 2.5cm
\bottommargin 2.5cm
\secnumdepth 3
\tocdepth 3
\paragraph_separation indent
\paragraph_indentation default
\quotes_language english
\papercolumns 1
\papersides 1
\paperpagestyle default
\tracking_changes false
\output_changes false
\html_math_output 0
\html_css_as_file 0
\html_be_strict false
\end_header

\begin_body

\begin_layout Title
SQL 7/19/2016
\end_layout

\begin_layout Author
Fan Yang
\begin_inset Foot
status open

\begin_layout Plain Layout
2013
\end_layout

\end_inset


\end_layout

\begin_layout Standard
SQL is a non-procedure language: You specify what you want, not how to do.
\end_layout

\begin_layout Part
SQL Interview
\end_layout

\begin_layout Itemize
When Join tables, 
\end_layout

\begin_deeper
\begin_layout Itemize
think things visiually
\end_layout

\begin_layout Itemize
think about which new information you want to bring in
\end_layout

\end_deeper
\begin_layout Itemize
It is CASE WHEN ...
 
\series bold
THEN
\series default
 ..
 , NOT CASE WHEN ...
 AS
\end_layout

\begin_deeper
\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

CASE WHEN ...
 THEN ...
 
\end_layout

\begin_layout Plain Layout

ELSE
\end_layout

\begin_layout Plain Layout

END
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
Be careful about ; and ,
\end_layout

\begin_layout Itemize
Group by 在 where 之后
\end_layout

\begin_layout Itemize
OUTER UNION CORR 最灵活-- match by name; UNION ALL 最严格 -- match by position,
 allow overlay
\end_layout

\begin_layout Itemize
Type of Questions
\end_layout

\begin_deeper
\begin_layout Itemize
Group by then Group by: 
\end_layout

\begin_deeper
\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select 
\end_layout

\begin_layout Plain Layout

	..
\end_layout

\begin_layout Plain Layout

from (
\end_layout

\begin_layout Plain Layout

	SELECT
\end_layout

\begin_layout Plain Layout

	  .., SUM() AS Y
\end_layout

\begin_layout Plain Layout

	FROM A 
\end_layout

\begin_layout Plain Layout

	GROUP BY X
\end_layout

\begin_layout Plain Layout

) AS DETACH
\end_layout

\begin_layout Plain Layout

GROUP BY DETACH.Y
\end_layout

\begin_layout Plain Layout

	
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
Left Join itself.
\end_layout

\begin_deeper
\begin_layout Itemize
The Main table may need to GROUP BY
\end_layout

\begin_layout Itemize
The Left table may also need to GROUP BY
\end_layout

\begin_layout Itemize
Be careful about the JOIN-ON KEY
\end_layout

\end_deeper
\end_deeper
\begin_layout Itemize
How to think:
\end_layout

\begin_deeper
\begin_layout Itemize
First think about what we need in the MAIN table
\end_layout

\begin_layout Itemize
Then think about what infor to bring from LEFT JOIN table
\end_layout

\begin_deeper
\begin_layout Itemize
What is the KEY to join on: maybe there are DOUBLE KEYS
\end_layout

\end_deeper
\end_deeper
\begin_layout Subsection
Method
\end_layout

\begin_layout Enumerate
Describe the general structure of the query you want to write
\end_layout

\begin_deeper
\begin_layout Enumerate
Let A join B, then group by or sum
\end_layout

\begin_layout Enumerate
Probably a subqquery is needed
\end_layout

\end_deeper
\begin_layout Enumerate
Clarify 
\end_layout

\begin_deeper
\begin_layout Enumerate
When two tables to join, if you are unsure: always ASK whether A table contains
 table B, or vice versa, or they are not mutually contained by each other
 
\end_layout

\begin_layout Enumerate
Why one variable is an Unique Indeitfier in the table, or it is possible
 to be duplicated? ------- Is one to many possible?
\end_layout

\end_deeper
\begin_layout Enumerate
First write From and Join ON 
\end_layout

\begin_deeper
\begin_layout Enumerate
Then write subquery
\end_layout

\begin_layout Enumerate
Then take care WHERE and GROUP BY
\end_layout

\end_deeper
\begin_layout Section
Sample Questions
\end_layout

\begin_layout Subsection
Conecptual Questions
\end_layout

\begin_layout Itemize
What does UNION do? What is the difference between UNION and UNION ALL?
\end_layout

\begin_layout Itemize
Consider the following two query results:
\end_layout

\begin_deeper
\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Itemize

SELECT count(*) AS total FROM orders;
\end_layout

\begin_layout Itemize

+-------+
\end_layout

\begin_layout Itemize

| total |
\end_layout

\begin_layout Itemize

+-------+
\end_layout

\begin_layout Itemize

| 100 |
\end_layout

\begin_layout Itemize

+-------+
\end_layout

\begin_layout Itemize

SELECT count(*) AS cust_123_total FROM orders WHERE customer_id = '123';
\end_layout

\begin_layout Itemize

+----------------+
\end_layout

\begin_layout Itemize

| cust_123_total |
\end_layout

\begin_layout Itemize

+----------------+
\end_layout

\begin_layout Itemize

| 15 |
\end_layout

\begin_layout Itemize

+----------------+
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Given the above query results, what will be the result of the query below?
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT count(*) AS cust_not_123_total FROM orders WHERE customer_id <> '123'
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Answer:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

The obvious answer is 85 (i.e, 100 - 15).
 However, that is not necessarily correct.
 Specifically, any records with a customer_id of NULL will not be included
 in either count (i.e., they won’t be included in cust_123_total, nor will
 they be included in cust_not_123_total).
 For example, if exactly one of the 100 customers has a NULL customer_id,
 the result of the last query will be:
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

+--------- ----------+
\end_layout

\begin_layout Plain Layout

| cust_not_123_total |
\end_layout

\begin_layout Plain Layout

+--------------------+
\end_layout

\begin_layout Plain Layout

|         84         |
\end_layout

\begin_layout Plain Layout

+--------------------+
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
What will be the result of the query below? Explain your answer and provide
 a version that behaves correctly.
\end_layout

\begin_deeper
\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Itemize

select case when null = null then 'Yup' else 'Nope' end as Result;
\end_layout

\begin_layout Itemize

\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Answer:
\end_layout

\begin_layout Itemize
This query will actually yield “Nope”, seeming to imply that null is not
 equal to itself! The reason for this is that the proper way to compare
 a value to null in SQL is with the is operator, not with =.
 Accordingly, the correct version of the above query that yields the expected
 result (i.e., “Yup”) would be as follows:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select case when null is null then 'Yup' else 'Nope' end as Result;
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
Given the following tables:
\end_layout

\begin_deeper
\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Itemize

sql> SELECT * FROM runners;
\end_layout

\begin_layout Itemize

+----+--------------+
\end_layout

\begin_layout Itemize

| id | name |
\end_layout

\begin_layout Itemize

+----+--------------+
\end_layout

\begin_layout Itemize

| 1 | John Doe |
\end_layout

\begin_layout Itemize

| 2 | Jane Doe |
\end_layout

\begin_layout Itemize

| 3 | Alice Jones |
\end_layout

\begin_layout Itemize

| 4 | Bobby Louis |
\end_layout

\begin_layout Itemize

| 5 | Lisa Romero |
\end_layout

\begin_layout Itemize

+----+--------------+
\end_layout

\begin_layout Itemize

sql> SELECT * FROM races;
\end_layout

\begin_layout Itemize

+----+----------------+-----------+
\end_layout

\begin_layout Itemize

| id | event | winner_id |
\end_layout

\begin_layout Itemize

+----+----------------+-----------+
\end_layout

\begin_layout Itemize

| 1 | 100 meter dash | 2 |
\end_layout

\begin_layout Itemize

| 2 | 500 meter dash | 3 |
\end_layout

\begin_layout Itemize

| 3 | cross-country | 2 |
\end_layout

\begin_layout Itemize

| 4 | triathalon | NULL |
\end_layout

\begin_layout Itemize

+----+----------------+-----------+
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
What will be the result of the query below?
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races)
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Explain your answer and also provide an alternative version of this query
 that will avoid the issue that it exposes.
\end_layout

\begin_layout Itemize

\series bold
Answer:
\end_layout

\begin_layout Itemize
Surprisingly, given the sample data provided, the result of this query will
 be an empty set.
 The reason for this is as follows: If the set being evaluated by the SQL
 NOT IN condition contains any values that are null, then the outer query
 here will return an empty set, even if there are many runner ids that match
 winner_ids in the races table.
\end_layout

\begin_layout Itemize
Knowing this, a query that avoids this issue would be as follows:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT * FROM runners WHERE id NOT IN (SELECT winner_id FROM races WHERE
 winner_id IS NOT null)
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
Given these contents of the Customers table:
\end_layout

\begin_deeper
\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Itemize

Id Name ReferredBy
\end_layout

\begin_layout Itemize

1 John Doe NULL
\end_layout

\begin_layout Itemize

2 Jane Smith NULL
\end_layout

\begin_layout Itemize

3 Anne Jenkins 2
\end_layout

\begin_layout Itemize

4 Eric Branford NULL
\end_layout

\begin_layout Itemize

5 Pat Richards 1
\end_layout

\begin_layout Itemize

6 Alice Barnes 2
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Here is a query written to return the list of customers not referred by
 Jane Smith:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT Name FROM Customers WHERE ReferredBy <> 2;
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
What will be the result of the query? Why? What would be a better way to
 write it?
\end_layout

\begin_layout Itemize

\series bold
Anwer:
\end_layout

\begin_layout Itemize
Although there are 4 customers not referred by Jane Smith (including Jane
 Smith herself), the query will only return one: Pat Richards.
 All the customers who were referred by nobody at all (and therefore have
 NULL in their ReferredBy column) don’t show up.
 But certainly those customers weren’t referred by Jane Smith, and certainly
 NULL is not equal to 2, so why didn’t they show up?
\end_layout

\begin_layout Itemize
SQL Server uses three-valued logic, which can be troublesome for programmers
 accustomed to the more satisfying two-valued logic (TRUE or FALSE) most
 programming languages use.
 In most languages, if you were presented with two predicates: ReferredBy
 = 2 and ReferredBy <> 2, you would expect one of them to be true and one
 of them to be false, given the same value of ReferredBy.
 In SQL Server, however, if ReferredBy is NULL, neither of them are true
 and neither of them are false.
 Anything compared to NULL evaluates to the third value in three-valued
 logic: UNKNOWN.
\end_layout

\begin_layout Itemize
The query should be written:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT Name FROM Customers WHERE ReferredBy IS NULL OR ReferredBy <> 2
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Watch out for the following, though!
\end_layout

\begin_layout Itemize
SELECT Name FROM Customers WHERE ReferredBy = NULL OR ReferredBy <> 2
\end_layout

\begin_layout Itemize
This will return the same faulty set as the original.
 Why? We already covered that: Anything compared to NULL evaluates to the
 third value in the three-valued logic: UNKNOWN.
 That “anything” includes NULL itself! That’s why SQL Server provides the
 IS NULL and IS NOT NULL operators to specifically check for NULL.
 Those particular operators will always evaluate to true or false.
\end_layout

\begin_layout Itemize
Even if a candidate doesn’t have a great amount of experience with SQL Server,
 diving into the intricacies of three-valued logic in general can give a
 good indication of whether they have the ability learn it quickly or whether
 they will struggle with it.
 
\end_layout

\end_deeper
\begin_layout Itemize
Assume a schema of Emp ( Id, Name, DeptId ) , Dept ( Id, Name).
\end_layout

\begin_deeper
\begin_layout Itemize
If there are 10 records in the Emp table and 5 records in the Dept table,
 how many rows will be displayed in the result of the following SQL query:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Select * From Emp, Dept
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Explain your answer.
 
\end_layout

\begin_layout Itemize
The query will result in 50 rows as a “cartesian product” or “cross join”,
 which is the default whenever the ‘where’ clause is omitted.
\end_layout

\end_deeper
\begin_layout Itemize
How can you select all the even number records from a table? All the odd
 number records?
\end_layout

\begin_deeper
\begin_layout Standard
To select all the even number records from a table:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Select * from table where id % 2 = 0 
\end_layout

\end_inset


\end_layout

\begin_layout Standard
To select all the odd number records from a table:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Select * from table where id % 2 != 0
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
Given a table dbo.users where the column user_id is a unique identifier,
 how can you efficiently select the first 100 odd user_id values from the
 table?
\end_layout

\begin_deeper
\begin_layout Itemize
(Assume the table contains well over 100 records with odd user_id values.)
 
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT TOP 100 user_id FROM dbo.users WHERE user_id % 2 = 1 ORDER BY user_id
 
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Subsection
Real Questions
\end_layout

\begin_layout Standard
Table A has two variables: id_x, id_y, feature_A, feature_B ....
 Feature_NOFULLSTIMER
\end_layout

\begin_layout Standard
where id_y values are in the same nature of id_x.
\end_layout

\begin_layout Itemize
Example
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Content_id, Commented, content_type, ....
\end_layout

\begin_layout Plain Layout

10035        NULL,        Picture
\end_layout

\begin_layout Plain Layout

10023,       10035, 	  Comment
\end_layout

\begin_layout Plain Layout

\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Questions 1: Find out all id_y with certain feature and with its corresponding
 id_x meeting certain feature requirment
\end_layout

\begin_layout Itemize
Questions 2: Find out all id_x with certain feature and with its corresponding
 id_y meeting certain feature requirment
\end_layout

\begin_layout Subsection
Query Qustions
\end_layout

\begin_layout Itemize
Given the following tables:
\end_layout

\begin_deeper
\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT * FROM users;
\end_layout

\begin_layout Plain Layout

user_id username
\end_layout

\begin_layout Plain Layout

1 John Doe 
\end_layout

\begin_layout Plain Layout

2 Jane Don 
\end_layout

\begin_layout Plain Layout

3 Alice Jones 
\end_layout

\begin_layout Plain Layout

4 Lisa Romero
\end_layout

\end_inset


\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT * FROM training_details;
\end_layout

\begin_layout Plain Layout

user_training_id user_id training_id training_date
\end_layout

\begin_layout Plain Layout

1 1 1 "2015-08-02"
\end_layout

\begin_layout Plain Layout

2 2 1 "2015-08-03"
\end_layout

\begin_layout Plain Layout

3 3 2 "2015-08-02"
\end_layout

\begin_layout Plain Layout

4 4 2 "2015-08-04"
\end_layout

\begin_layout Plain Layout

5 2 2 "2015-08-03"
\end_layout

\begin_layout Plain Layout

6 1 1 "2015-08-02"
\end_layout

\begin_layout Plain Layout

7 3 2 "2015-08-04"
\end_layout

\begin_layout Plain Layout

8 4 3 "2015-08-03"
\end_layout

\begin_layout Plain Layout

9 1 4 "2015-08-03"
\end_layout

\begin_layout Plain Layout

10 3 1 "2015-08-02"
\end_layout

\begin_layout Plain Layout

11 4 2 "2015-08-04"
\end_layout

\begin_layout Plain Layout

12 3 2 "2015-08-02"
\end_layout

\begin_layout Plain Layout

13 1 1 "2015-08-02"
\end_layout

\begin_layout Plain Layout

14 4 3 "2015-08-03"
\end_layout

\end_inset


\end_layout

\begin_layout Standard
Write a query to to get the list of users who took the a training lesson
 more than once in the same day, grouped by user and training lesson, each
 ordered from the most recent lesson date to oldest date.
\end_layout

\begin_layout Itemize
Answer
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT
\end_layout

\begin_layout Plain Layout

      u.user_id,
\end_layout

\begin_layout Plain Layout

      username,
\end_layout

\begin_layout Plain Layout

      training_id,
\end_layout

\begin_layout Plain Layout

      training_date,
\end_layout

\begin_layout Plain Layout

      count( user_training_id ) AS count
\end_layout

\begin_layout Plain Layout

  FROM users u JOIN training_details t ON t.user_id = u.user_id
\end_layout

\begin_layout Plain Layout

  GROUP BY user_id,
\end_layout

\begin_layout Plain Layout

           training_id,
\end_layout

\begin_layout Plain Layout

           training_date
\end_layout

\begin_layout Plain Layout

  HAVING count( user_training_id ) > 1
\end_layout

\begin_layout Plain Layout

  ORDER BY training_date DESC;
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

user_id  username      training_id  training_date             count
\end_layout

\begin_layout Plain Layout

4        Lisa Romero   2            August, 04 2015 00:00:00  2
\end_layout

\begin_layout Plain Layout

4        Lisa Romero   3            August, 03 2015 00:00:00  2
\end_layout

\begin_layout Plain Layout

1        John Doe      1            August, 02 2015 00:00:00  3
\end_layout

\begin_layout Plain Layout

3        Alice Jones   2            August, 02 2015 00:00:00  2
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
Question 1: SQL Query to find second highest salary of Employee
\end_layout

\begin_deeper
\begin_layout Standard
Answer: There are many ways to find second highest salary of Employee in
 SQL, you can either use SQL Join or Subquery to solve this problem.
 Here is SQL query using Subquery:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select MAX(Salary) from Employee WHERE Salary NOT IN (select MAX(Salary)
 from Employee ); 
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
find all Employee records containing the word "Joe", regardless of whether
 it was stored as JOE, Joe, or joe.
 Answer :
\end_layout

\begin_deeper
\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT * from Employees WHERE UPPER(EmpName) like '%JOE%';
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
There is a table which contains two column Student and Marks, you need to
 find all the students, whose marks are greater than average marks i.e.
 list of above average students.
\end_layout

\begin_deeper
\begin_layout Itemize
Answer: This query can be written using subquery as shown below:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT student, marks from table where marks > SELECT AVG(marks) from table)
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
How do you find all employees which are also manager? .
\end_layout

\begin_deeper
\begin_layout Itemize
You have given a standard employee table with an additional column mgr_id,
 which contains employee id of the manager.
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select 
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

a.employee_id
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

from employee as a 
\end_layout

\begin_layout Plain Layout

inner join 
\end_layout

\begin_layout Plain Layout

	(select b.manager_id, sum(1) as count from employee as b)  as b
\end_layout

\begin_layout Plain Layout

on b.manager_id = a.employee_id;
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
How to select first 5 records from a table?
\end_layout

\begin_deeper
\begin_layout Itemize
This question, often asked in many interviews, does not make any sense to
 me.
 The problem here is how do you define which record is first and which is
 second.
 Which record is retrieved first from the database is not deterministic.
 It depends on many uncontrollable factors such as how database works at
 that moment of execution etc.
 So the question should really be – “how to select any 5 records from the
 table?” But whatever it is, here is the solution:
\end_layout

\begin_layout Itemize
In Oracle,
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Itemize

SELECT * 
\end_layout

\begin_layout Itemize

FROM EMP
\end_layout

\begin_layout Itemize

WHERE ROWNUM <= 5;
\end_layout

\begin_layout Itemize

\end_layout

\end_inset


\end_layout

\begin_layout Itemize
In SQL Server,
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT TOP 5 * FROM EMP;
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
SELECT TOP 5 * FROM EMP;
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT  name 
\end_layout

\begin_layout Plain Layout

FROM EMPLOYEE o
\end_layout

\begin_layout Plain Layout

WHERE (SELECT count(*) FROM EMPLOYEE i WHERE i.name < o.name) < 5
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
How to generate row number in SQL Without ROWNUM
\end_layout

\begin_deeper
\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT name, sal, (SELECT COUNT(*) FROM EMPLOYEE i WHERE o.name >= i.name)
 row_num
\end_layout

\begin_layout Plain Layout

FROM EMPLOYEE o
\end_layout

\begin_layout Plain Layout

order by row_num
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

NAME SAL ROW_NUM
\end_layout

\begin_layout Plain Layout

Anno 80 1
\end_layout

\begin_layout Plain Layout

Bhuti 60 2
\end_layout

\begin_layout Plain Layout

Darl 80 3
\end_layout

\begin_layout Plain Layout

Hash 100 4
\end_layout

\begin_layout Plain Layout

Inno 50 5
\end_layout

\begin_layout Plain Layout

Meme 60 6
\end_layout

\begin_layout Plain Layout

Pete 70 7
\end_layout

\begin_layout Plain Layout

Privy 50 8
\end_layout

\begin_layout Plain Layout

Robo 100 9
\end_layout

\begin_layout Plain Layout

Tomiti 70 10
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Section
Clairfy
\end_layout

\begin_layout Section
Resources
\end_layout

\begin_layout Subsection
Resources for Advanced
\end_layout

\begin_layout Itemize
http://www.programmerinterview.com/index.php/database-sql/advanced-sql-interview-qu
estions-and-answers/
\end_layout

\begin_layout Standard
Try SQL exercises (SQL - Ex .
 ru) --It has different scenario based exercises and a great online practice
 area where you can instantly write the queries and see the result straightaway.
 Also, you can try different questions based on the level of difficulty
 you are comfortable with.
\end_layout

\begin_layout Standard
Yes ..Here is one best website that provide online tutorial and online practice
 set for SQL.
\end_layout

\begin_layout Standard
SQL Tutorial and Test Paper with simple example on Installation,Basic Syntax,Dat
a Types, Create DB,Create Table,Insert,Delete etc.
 Here you can download pdf SQL Tutorial SQL Interview Questions and Answers.
 And you can find also SQL interview questions and answers & online Skill
 Test on Database SQL Server Online Quiz | Online Test | Mock Exam
\end_layout

\begin_layout Subsection
Practise Tools
\end_layout

\begin_layout Standard
Not online but consider using http://www.sqlite.org/ which is a "self-contained,
 serverless, zero-configuration, transactional SQL database engine.".
 You can put the database file in a Dropbox folder and use the https://addons.moz
illa.org/en-US...
 Firefox addon to access the database.
 
\end_layout

\begin_layout Part
Topics
\end_layout

\begin_layout Subsubsection
Data Consistency
\end_layout

\begin_layout Standard
一致性就是数据保持一致，在分布式系统中，可以理解为多个节点中数据的值是一致的。
\end_layout

\begin_layout Standard
而一致性又可以分为强一致性与弱一致性.
\end_layout

\begin_layout Enumerate
强一致性可以理解为在任意时刻，所有节点中的数据是一样的。同一时间点，你在节点A中获取到key1的值与在节点B中获取到key1的值应该都是一样的。
\end_layout

\begin_layout Enumerate
弱一致性包含很多种不同的实现，目前分布式系统中广泛实现的是最终一致性。
\end_layout

\begin_layout Enumerate
所谓最终一致性，就是不保证在任意时刻任意节点上的同一份数据都是相同的，但是随着时间的迁移，不同节点上的同一份数据总是在向趋同的方向变化。也可以简单的理解为在一段
时间后，节点间的数据会最终达到一致状态。
\end_layout

\begin_layout Subsubsection
CAP theorem
\end_layout

\begin_layout Standard
Also known as
\begin_inset space ~
\end_inset


\series bold
Brewer's theorem
\series default
, states that it is impossible for a Distributed computing to simultaneously
 provide all three of the following guarantees
\end_layout

\begin_layout Itemize
Consistency: all nodes see the same data at the same time) 
\end_layout

\begin_layout Itemize
Availability: (a guarantee that every request receives a response about
 whether it succeeded or failed) 
\end_layout

\begin_layout Itemize
Partition tolerance: (the system continues to operate despite arbitrary
 message loss or failure of part of the system) 
\end_layout

\begin_layout Subsubsection
3V
\end_layout

\begin_layout Itemize
Volume 
\end_layout

\begin_layout Itemize
Velocity 
\end_layout

\begin_layout Itemize
Variety: data from different sources (distributed locations), or different
 types 
\end_layout

\begin_layout Section
Map Reduce
\end_layout

\begin_layout Standard
http://stackoverflow.com/questions/28982/please-explain-mapreduce-simply
\end_layout

\begin_layout Standard
The model is inspired by the
\series bold
 map 
\series default
and
\series bold
 reduce 
\series default
functions commonly used in Functional_programming, although their purpose
 in the MapReduce framework is not the same as in their original forms.
\end_layout

\begin_layout Standard
MapReduce
\begin_inset space ~
\end_inset

have been written in many programming languages, with different levels of
 optimization.
 A popular
\begin_inset space ~
\end_inset

implementation is Apache_Hadoop
\end_layout

\begin_layout Standard
MapReduce can take advantage of locality of data, processing it on or near
 the storage assets in order to reduce the distance over which it must be
 transmitted.
\end_layout

\begin_layout Enumerate

\series bold
"Map" step:
\series default
 Each worker node applies the "map()" function to the local data, and writes
 the output to a temporary storage.
 A master node orchestrates that for redundant copies of input data, only
 one is processed.
 
\end_layout

\begin_deeper
\begin_layout Enumerate
Map is an idiom in parallel computing where a simple operation is applied
 to all elements of a sequence, potentially in parallel
\end_layout

\begin_layout Enumerate
square x = x * x
\end_layout

\begin_layout Enumerate
Afterwards we may call
\end_layout

\begin_layout Enumerate
>>> map square [1, 2, 3, 4, 5]
\end_layout

\begin_layout Enumerate
which yields [1, 4, 9, 16, 25]
\end_layout

\end_deeper
\begin_layout Enumerate

\series bold
"Shuffle" step:
\series default
 Worker nodes redistribute data based on the output keys (produced by the
 "map()" function), such that all data belonging to one key is located on
 the same worker node.
 
\end_layout

\begin_layout Enumerate

\series bold
"Reduce" step:
\series default
 Worker nodes now process each group of output data, per key, in parallel.
 
\end_layout

\begin_layout Standard
In many situations, the input data might already be distributed (among many
 different servers, in which case step 1 could sometimes be greatly simplified
 by assigning Map servers that would process the locally present input data.
 Similarly, step 3 could sometimes be sped up by assigning Reduce processors
 that are as close as possible to the Map-generated data they need to process.
\end_layout

\begin_layout Section
NoSQL
\end_layout

\begin_layout Standard
Relational data has to be defined and stored in a table like format.
\end_layout

\begin_layout Standard
比如 有一个学生的数据：
\end_layout

\begin_layout Standard
\begin_inset space ~
\end_inset


\begin_inset space ~
\end_inset


\begin_inset space ~
\end_inset


\begin_inset space ~
\end_inset

姓名：张三，性别：男，学号：12345，班级：二年级一班
\end_layout

\begin_layout Standard
还有一个班级的数据：
\end_layout

\begin_layout Standard
\begin_inset space ~
\end_inset


\begin_inset space ~
\end_inset


\begin_inset space ~
\end_inset


\begin_inset space ~
\end_inset

班级：二年级一班，班主任：李四
\end_layout

\begin_layout Standard
非关系型数据库中，我们创建两个对象，一个是学生对象，一个是班级对象，用java来表示就是：
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

classStudent{ 
\end_layout

\begin_layout Plain Layout

	Stringid; 
\end_layout

\begin_layout Plain Layout

	Stringname; 
\end_layout

\begin_layout Plain Layout

	Stringsex; 
\end_layout

\begin_layout Plain Layout

	Stringnumber; 
\end_layout

\begin_layout Plain Layout

	Stringclassid; 
\end_layout

\begin_layout Plain Layout

} 
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

classGrade{ 
\end_layout

\begin_layout Plain Layout

	Stringid; 
\end_layout

\begin_layout Plain Layout

	Stringname; 
\end_layout

\begin_layout Plain Layout

	Stringteacher; 
\end_layout

\begin_layout Plain Layout

}
\end_layout

\end_inset


\end_layout

\begin_layout Standard
通过设置Student类的classid等于Grade类的id来建立这种关系；
\end_layout

\begin_layout Standard
非关系型数据库中，我们查询一条数据，结果出来一个数组，关系型数据库中，查询一条数据结果是一个对象。
\end_layout

\begin_layout Part
Relational Data
\end_layout

\begin_layout Standard
For data access
\end_layout

\begin_layout Itemize

\series bold
Primary Index
\series default
 shall be defined to provide a nearly uniform distribution of rows among
 each disk that stored data (AMP in teradata).
 The more unique the index, the more even the distribution of rows and better
 space utilization.
\end_layout

\begin_layout Itemize

\series bold
Secondary Index
\series default
: allows access to information in a table by alternate, less frequently
 used paths and improve performance by avoiding full table scans.
\end_layout

\begin_layout Standard
For observation identification 
\end_layout

\begin_layout Itemize

\series bold
Primary Key
\series default
: The primary key is the column or set of columns used to uniquely identify
 the items in a table.
 different from primary index.
 It identifies a row uniquely but not imply data access path
\end_layout

\begin_layout Standard
For linkage between tables.
\end_layout

\begin_layout Itemize

\series bold
Foreign Key 
\series default
in the table is to identify relationships with other tables.
 Thus this foreign key shall be the prime key for those other tables to
 be matched or comared.
\end_layout

\begin_layout Subsection
Cardinality
\end_layout

\begin_layout Standard
In SQL (Structured Query Language), the term cardinality refers to the uniquenes
s of data values contained in a particular column (attribute) of a database
 table.
 
\end_layout

\begin_layout Standard
The lower the cardinality, the more duplicated elements in a column.
 Thus, a column with the lowest possible cardinality would have the same
 value for every row.
 SQL databases use cardinality to help determine the optimal query plan
 for a given query.
\end_layout

\begin_layout Section
SQL Statement types
\end_layout

\begin_layout Standard
Data Definition Language (DDL) statements are used to define the database
 structure or schema.
 Some examples:
\end_layout

\begin_layout Itemize
CREATE - to create objects in the database 
\end_layout

\begin_layout Itemize
ALTER - alters the structure of the database 
\end_layout

\begin_layout Itemize
DROP - delete objects from the database 
\end_layout

\begin_layout Itemize
TRUNCATE - remove all records from a table, including all spaces allocated
 for the records are removed 
\end_layout

\begin_layout Itemize
COMMENT - add comments to the data dictionary 
\end_layout

\begin_layout Itemize
RENAME - rename an object 
\end_layout

\begin_layout Standard

\series bold
Data Manipulation Language
\series default

\begin_inset space ~
\end_inset

(DML) statements are used for managing data within schema objects.
 Some examples:
\end_layout

\begin_layout Itemize
SELECT - retrieve data from the a database 
\end_layout

\begin_layout Itemize
INSERT - insert data into a table 
\end_layout

\begin_layout Itemize
UPDATE - updates existing data within a table 
\end_layout

\begin_layout Standard

\series bold
Data Control Language
\series default

\begin_inset space ~
\end_inset

(DCL) statements.
 Some examples:
\end_layout

\begin_layout Itemize
GRANT - gives user's access privileges to database 
\end_layout

\begin_layout Itemize
REVOKE - withdraw access privileges given with the GRANT command 
\end_layout

\begin_layout Section
Local and Server
\end_layout

\begin_layout Standard

\series bold
Local
\end_layout

\begin_layout Standard
Define the local working directory (permanent storage of data)
\end_layout

\begin_layout Standard
libname out '/sasusr/saswork/Fan_Yang/';
\end_layout

\begin_layout Standard
That is your working library.
 Use out.dataset_name to refer any table in it.
\end_layout

\begin_layout Standard
WORK and OUT libraries are in local.
 Other schema and db2lib library are in DB2 server.
\end_layout

\begin_layout Standard

\series bold
Server
\end_layout

\begin_layout Enumerate
If refer schema in db2, then have to use the code template below 
\end_layout

\begin_layout Subsection
Code template in server 
\end_layout

\begin_layout Standard
PROC SQL;
\end_layout

\begin_layout Standard
CONNECT TO DB2(DATABASE=fnndw5); /*fnndw5 or 4 are both ok*/
\end_layout

\begin_layout Standard
create table \SpecialChar \ldots{}
 as
\end_layout

\begin_layout Standard
SELECT \SpecialChar \ldots{}

\end_layout

\begin_layout Standard
from connection to db2
\end_layout

\begin_layout Standard
(select \SpecialChar \ldots{}
 from); /*You have to use derived table*/
\end_layout

\begin_layout Standard
If not use either 
\series bold
the bold
\series default
 
\series bold
connection line below,
\series default
 then error: schema is read only.
\end_layout

\begin_layout Subsection
MIX use both local and server data:
\end_layout

\begin_layout Itemize
How: in the outside table, still write 
\end_layout

\begin_layout Standard
CONNECT TO DB2(DATABASE=fnndw5);
\end_layout

\begin_layout Standard
then write
\end_layout

\begin_layout Standard
from (select..
\end_layout

\begin_layout Standard
from local_data
\end_layout

\begin_layout Standard
join by server_Data),
\end_layout

\begin_layout Quote
a simple derived table 
\series bold
without connection to db2
\series default
 after first 
\series bold
from.

\series default
 
\end_layout

\begin_layout Itemize
Cons: Much slower than purely use server data
\series bold
.

\series default
 For dataset you use a lot of time and not big, and has to be used with
 schema in server, it is better to write it in db2lib.
 
\end_layout

\begin_layout Section
Integrity Constraints
\end_layout

\begin_layout Standard
To display only the table constraints for the table 
\emph on
Work.Discount4
\end_layout

\begin_layout Standard
proc sql;
\end_layout

\begin_layout Standard
describe table constraints work.discount4;
\end_layout

\begin_layout Subsection
Within the column specification statement
\end_layout

\begin_layout Standard

\series bold
All other constraints: see page 203 in Advanced SAS.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create table work.employees
\end_layout

\begin_layout Plain Layout

(ID char (5) primary key,
\end_layout

\begin_layout Plain Layout

Name char(10),
\end_layout

\begin_layout Plain Layout

Gender char(1) not null check(gender in ('M','F')),
\end_layout

\begin_layout Plain Layout

HDate date label='Hire Date');
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
PRIMARY KEY column constraint ensures that the 
\series bold
ID
\series default
 column will contain only values that are nonmissing and unique.
 
\end_layout

\begin_layout Itemize
The column specification for 
\series bold
Gender
\series default
 defines two integrity constraints: The NOT NULL column constraint ensures
 that the values of 
\series bold
Gender
\series default
 will be
\end_layout

\begin_deeper
\begin_layout Itemize
nonmissing values. The CHECK column constraint ensures that the values of
 
\series bold
Gender
\series default
 will satisfy the 
\end_layout

\begin_layout Itemize
expression 
\series bold
gender in ('M','F')
\series default
.
 
\end_layout

\end_deeper
\begin_layout Subsection
After the column specification statement
\end_layout

\begin_layout Standard
Advantage compared with constraints in column specification statement
\end_layout

\begin_layout Itemize
You can specify a name for the constraint.
 In fact, you must specify a name, because SAS does not automatically assign
 one.
 
\end_layout

\begin_layout Itemize
For certain constraint types, you can define a constraint for multiple columns
 in a single specification.
 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create table work.discount3
\end_layout

\begin_layout Plain Layout

(Destination char(3),
\end_layout

\begin_layout Plain Layout

BeginDate num Format=date9.,
\end_layout

\begin_layout Plain Layout

EndDate num format=date9.,
\end_layout

\begin_layout Plain Layout

Discount num,
\end_layout

\begin_layout Plain Layout

constraint ok_discount check (discount le .5),
\end_layout

\begin_layout Plain Layout

constraint notnull_dest not null(destination));
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
The CHECK integrity constraint named 
\series bold
OK_Discount
\series default
 uses the WHERE expression 
\series bold
discount le .5
\series default
 to limit the values that can be added to the 
\series bold
Discount
\series default
 column.
 
\end_layout

\begin_layout Itemize
The NOT NULL integrity constraint named 
\series bold
NotNull_Dest
\series default
 prevents missing values from being entered in 
\series bold
Destination
\series default
.
 
\end_layout

\begin_layout Subsection
UNDO_POLICY and Errors in Row Insertions
\end_layout

\begin_layout Standard
If you add data that does 
\emph on
not
\emph default
 comply with the integrity constraints, the rows are 
\emph on
not
\emph default
 added.
 To find out whether rows of data have been successfully added, you need
 to check the SAS log.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Undo_Policy option
\end_layout

\begin_layout Plain Layout

proc sql undo_policy=none;
\end_layout

\begin_layout Plain Layout

\end_layout

\end_inset


\end_layout

\begin_layout Standard
Even if the inserted row is not in compliance with constrants, it still
 gets in, though with error in log.
\end_layout

\begin_layout Section
Efficiency
\end_layout

\begin_layout Subsection
CPU TIME
\end_layout

\begin_layout Standard
The amount of time the central processing unit (CPU) uses to perform requested
 tasks such as calculations, reading and writing data, conditional logic,
 and iterative logic.
\end_layout

\begin_layout Subsection
REAL TIME
\end_layout

\begin_layout Standard
Mainly include I/O time
\end_layout

\begin_layout Standard
The clock time (elapsed time) it takes to execute a job or step.
 Real time is heavily dependent on the capacity of the system and on the
 load (the number of users that are sharing the system's resources).
\end_layout

\begin_layout Standard
Because you cannot always control the capacity and the load demands on your
 system, real time is sometimes a less useful measure of program efficiency
 than CPU time.
 However, excessive use of real time often motivates programmers to improve
 a program's efficiency.
 Some procedures in SAS 9.1 give you the option of using 
\series bold
threaded processing
\series default
 to reduce real time.
 Threaded processing can cause an increase in CPU time, so it is recommended
 that you track both CPU time and real time.
\end_layout

\begin_layout Subsection
I/O
\end_layout

\begin_layout Standard
a measurement of the read and write operations that are performed as data
 and programs are copied from a storage device to memory (input) or from
 memory to a storage or display device (output).
\end_layout

\begin_layout Subsection
Auto Optimization
\end_layout

\begin_layout Itemize
Derived table is efficient, at least below the first FROM.
 SQL will optimize from the whole SQL code, so it can consider the WHERE
 and other constraints at different level at the same time.
\end_layout

\begin_layout Itemize
in WHERE statement, it would be most efficient to write general restriction
 before exact restriction.
\end_layout

\begin_deeper
\begin_layout Itemize
For example, WHERE MONTH=&VINTAGE and APPL_ID=\SpecialChar \ldots{}
.
 Is much quicker thant just writing WHERE APPL_ID=\SpecialChar \ldots{}
.
 As the latter one has to search the APPL_ID for the whole population, whereas
 the first one only needs to search APPL_ID within subsample of MONTH=&VINTAGE
\end_layout

\end_deeper
\begin_layout Subsection
How to Track efficiency
\end_layout

\begin_layout Standard

\series bold
STIMER
\end_layout

\begin_layout Itemize
Specifies that 
\emph on
CPU time and real-time statistics
\emph default
 are to be 
\emph on
tracked and written
\emph default
 to the SAS log throughout the SAS session.
 
\end_layout

\begin_layout Itemize
Can be set 
\emph on
either
\emph default
 at invocation or by using an OPTIONS statement.
 
\end_layout

\begin_layout Itemize
Is the 
\emph on
default
\emph default
 setting.
 
\end_layout

\begin_layout Standard

\series bold
FULLSTIMER
\end_layout

\begin_layout Itemize
Specifies that 
\emph on
all available resource usage statistics
\emph default
 are to be 
\emph on
tracked and written
\emph default
 to the SAS log throughout the SAS session.
 
\end_layout

\begin_layout Itemize
Can be set 
\emph on
either
\emph default
 at invocation or by using an OPTIONS statement.
 
\end_layout

\begin_layout Itemize
In Windows operating environments, some statistics will not be calculated
 accurately unless FULLSTIMER is specified at invocation.
 
\end_layout

\begin_layout Standard
You can turn off any of these system options by using the options below:
 NOSTIMER
\end_layout

\begin_layout Itemize
NOMEMRPT 
\end_layout

\begin_layout Itemize
NOFULLSTIMER 
\end_layout

\begin_layout Itemize
NOSTATS.
 
\end_layout

\begin_layout Subsection
Control I/O Time
\end_layout

\begin_layout Standard
When you create a SAS data set using a DATA step,
\end_layout

\begin_layout Standard

\series bold
1 
\series default
SAS copies the data from the input data set to a buffer in memory
\end_layout

\begin_layout Standard

\series bold
2 
\series default
one observation at a time is loaded into the program data vector
\end_layout

\begin_layout Standard

\series bold
3 
\series default
each observation is written to an output buffer when processing is complete
\end_layout

\begin_layout Standard

\series bold
4 
\series default
the contents of the output buffer are written to the disk when the buffer
 is full.
\end_layout

\begin_layout Itemize
It is important to note that I/O processing is reduced only if there is
 sufficient real memory.
 If there is not sufficient real memory, the operating environment might
\end_layout

\begin_deeper
\begin_layout Itemize
use virtual memory 
\end_layout

\begin_layout Itemize
use the default number of buffers.
 
\end_layout

\end_deeper
\begin_layout Subsection
Page Size
\end_layout

\begin_layout Standard
Definition: The amount of data that can be transferred to one buffer in
 a single I/O operation is referred to as 
\emph on
page size
\emph default
.
 Page size is analogous to buffer size for SAS data sets.
\end_layout

\begin_layout Standard
A larger page size can reduce execution time by reducing the number of times
 SAS has to read from or write to the storage medium.
 However, the improvement in execution time comes at the cost of increased
 memory consumption.
\end_layout

\begin_layout Standard

\series bold
Report Page Size
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc contents data=company.order_fact;
\end_layout

\begin_layout Plain Layout

run;
\end_layout

\begin_layout Plain Layout

Control Page Size
\end_layout

\begin_layout Plain Layout

BUFSIZE=0;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
is interpreted as a request for the default page/buffer size:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

options bufsize=30720; 
\end_layout

\begin_layout Plain Layout

filename orders 'c:
\backslash
orders.dat';
\end_layout

\begin_layout Plain Layout

data company.orders_fact;
\end_layout

\begin_layout Plain Layout

BUFSIZE= system option specifies a page size of 30720 bytes.
\end_layout

\end_inset


\end_layout

\begin_layout Standard

\series bold
Rather than setting system option, set dataset option
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

data work.orders (bufsize=6144 bufno=2);
\end_layout

\begin_layout Plain Layout

set retail.order_fact;
\end_layout

\begin_layout Plain Layout

run;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
SASFILE: hold multiple datasets into memory
\end_layout

\begin_layout Standard
Another way of improving performance is to use the SASFILE statement to
 hold a SAS data file 
\series bold
in memory so that the data is available to multiple program steps
\series default
.
 Keeping the data file open reduces open/close operations, including the
 allocation and freeing of memory for buffers.
\end_layout

\begin_layout Standard

\series bold
SASFILE
\series default
 
\emph on
SAS-data-file
\emph default
 
\emph on
password-option(s)
\emph default
)
\series bold
 OPEN LOAD CLOSE;
\end_layout

\begin_layout Itemize

\emph on
SAS-data-file
\emph default
: is a valid SAS data file (a SAS data set with the member type DATA).
 
\end_layout

\begin_layout Itemize

\emph on
password-option(s)
\emph default
: specifies one or more password options.
 
\end_layout

\begin_layout Itemize
OPEN : opens the file and allocates the buffers, but defers reading the
 data into memory until a procedure or statement is executed.
 
\end_layout

\begin_layout Itemize
LOAD : opens the file, allocates the buffers, and reads the data into memory.
 
\end_layout

\begin_layout Itemize
CLOSE:  closes the file and frees the buffers.
 
\end_layout

\begin_layout Standard
Once the data file is read, the data is held in memory, and it is available
 to subsequent DATA and PROC steps or applications until either
\end_layout

\begin_layout Standard
A SASFILE CLOSE statement frees the buffers and closes the file the program
 ends, which automatically frees the buffers and closes the file.
\end_layout

\begin_layout Standard

\series bold
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

sasfile company.sales load;
\end_layout

\begin_layout Plain Layout

proc print data=company.sales;
\end_layout

\begin_layout Plain Layout

var Customer_Age_Group;
\end_layout

\begin_layout Plain Layout

run;
\end_layout

\begin_layout Plain Layout

proc tabulate data=company.sales;
\end_layout

\begin_layout Plain Layout

class Customer_Age_Group;
\end_layout

\begin_layout Plain Layout

var Customer_BirthDate;
\end_layout

\begin_layout Plain Layout

table Customer_Age_Group,Customer_BirthDate*(mean median);
\end_layout

\begin_layout Plain Layout

run;
\end_layout

\begin_layout Plain Layout

sasfile company.sales close;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Control Storage
\end_layout

\begin_layout Standard
Reduce character variable's length.
 Use numeric variable to represent character variable whenever we can,
\end_layout

\begin_layout Part
Expressions
\end_layout

\begin_layout Subsection
Orders of expression
\end_layout

\begin_layout Standard
General form, basic PROC SQL step to perform a query:
\end_layout

\begin_layout Standard

\emph on
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

PROC SQL;
\end_layout

\begin_layout Plain Layout

SELECT column-1,...column-n
\end_layout

\begin_layout Plain Layout

FROM table-1view-1,...table-view-n
\end_layout

\begin_layout Plain Layout

WHERE expression
\end_layout

\begin_layout Plain Layout

GROUP BY column-1, ...
 column-n
\end_layout

\begin_layout Plain Layout

ORDER BY column-1,...
 column-n
\end_layout

\end_inset


\end_layout

\begin_layout Enumerate
PROC SQL invokes the SQL procedure 
\end_layout

\begin_layout Enumerate
SELECT specifies the column(s) to be selected 
\end_layout

\begin_layout Enumerate
FROM specifies the table(s) to be queried 
\end_layout

\begin_layout Enumerate
WHERE subsets the data based on a condition 
\end_layout

\begin_layout Enumerate
GROUP BY classifies the data into groups based on the specified column(s)
 
\end_layout

\begin_layout Enumerate
ORDER BY sorts the rows that the query returns by the value(s) of the specified
 column(s).
 
\end_layout

\begin_layout Standard
SELECT statement will automatically generate report.
\end_layout

\begin_layout Standard
To create table in PROC SQL, just use CREAT TABLE \SpecialChar \ldots{}
AS before SELECT.
\end_layout

\begin_layout Standard
proc sql;
\end_layout

\begin_layout Standard

\series bold
create table
\series default
 work.miles 
\series bold
as
\end_layout

\begin_layout Standard
select membertype
\end_layout

\begin_layout Standard
CAUTION:
\end_layout

\begin_layout Itemize
Clauses must appear in the order shown above.
 
\end_layout

\begin_layout Itemize
No need for RUN in the end.
 
\end_layout

\begin_layout Itemize
No need for QUClauses must appear in the order shown above.
 IT in the end.
 
\end_layout

\begin_layout Itemize
in SQL queries, the WHERE clause is processed prior to the SELECT clause.
 So any variable created by SELECT..AS..
 cannot be used directly in WHERE 
\end_layout

\begin_layout Standard
Example
\end_layout

\begin_layout Standard

\series bold
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select empid,jobcode,salary, * select column
\end_layout

\begin_layout Plain Layout

salary*.06 as bonus * create new column `Bonus' using AS 
\end_layout

\begin_layout Plain Layout

from sasuser.payrollmaster
\end_layout

\begin_layout Plain Layout

where salary32000 * Condition: Subsetting data
\end_layout

\begin_layout Plain Layout

order by jobcode; * Order By rows, you can put multiple variable 
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Where: Condition of SELECT
\end_layout

\begin_layout Standard
See p47 in ADVANCED SAS.
\end_layout

\begin_layout Standard
You can use the following PROC SQL query to retrieve rows from the table
 that have missing values:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

where boarded is missing;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
CALCULATED for newly created variable
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql outobs=10;
\end_layout

\begin_layout Plain Layout

select flightnumber, date, destination,
\end_layout

\begin_layout Plain Layout

boarded + transferred + nonrevenue as Total
\end_layout

\begin_layout Plain Layout

calculated total/2 as Half * Get another new variable Half from Newly created
 variable Total 
\end_layout

\begin_layout Plain Layout

from sasuser.marchflights
\end_layout

\begin_layout Plain Layout

where calculated total = 100;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
Without calculated, then there will be an error, as WHERE comes before SELECT..
 AS..
\end_layout

\begin_layout Subsection
HAVING
\end_layout

\begin_layout Itemize

\series bold
HAVING is used to check conditions after the aggregation takes place.
\end_layout

\begin_layout Itemize

\series bold
WHERE is used before the aggregation takes place.
\end_layout

\begin_layout Itemize
Select only a 
\emph on
subset of groups
\emph default
 for your query output.
 You can use a 
\emph on
HAVING
\emph default
 clause, following a GROUP BY clause,
\end_layout

\begin_layout Itemize
Note that you do 
\emph on
not
\emph default
 have to specify the keyword CALCULATED in a HAVING clause; you would have
 to specify it in a WHERE clause.
\end_layout

\begin_layout Standard
If you omit the GROUP BY clause in a query that contains a HAVING clause,
 then the HAVING clause and summary functions (if any are specified) treat
 the entire table as one group.
\end_layout

\begin_layout Standard
Summary Functions can go into HAVING
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select jobcode,
\end_layout

\begin_layout Plain Layout

avg(salary) as AvgSalary
\end_layout

\begin_layout Plain Layout

format=dollar11.2
\end_layout

\begin_layout Plain Layout

from sasuser.payrollmaster
\end_layout

\begin_layout Plain Layout

group by jobcode
\end_layout

\begin_layout Plain Layout

having avg(salary) >=56000;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
ORDER BY
\end_layout

\begin_layout Enumerate
By default it is ascending, but can also in descending order by DESC
\end_layout

\begin_layout Enumerate
ORDER BY Variable1, Variable2 
\series bold
DESC
\series default
;
\end_layout

\begin_layout Subsection
CASE WHEN
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

CASE WHEN CONDITONTHEN ...ACTION
\end_layout

\begin_layout Quote

WHEN..
 THEN..
\end_layout

\begin_layout Quote

ELSE 
\end_layout

\begin_layout Plain Layout

END AS NEW_VARIABLE_NAME
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
ELSE is not necessary.
 If ELSE is missing, then all values falling into ELSE are regarded as NULL
 
\end_layout

\begin_layout Itemize
Joint or complicated Conditions may need to use brackets around them.
 
\end_layout

\begin_layout Itemize
Then second (n+1) WHEN will automatically exclude the first (n) WHEN.
 
\end_layout

\begin_layout Standard
quit;
\end_layout

\begin_layout Subsection
Distinct
\end_layout

\begin_layout Standard
Distinct is often used with group if no calculation, otherwise there is
 no point to use group.
\end_layout

\begin_layout Standard
Choose the unique combinations of multiple columns.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

FROM (  
\end_layout

\begin_layout Plain Layout

SELECT  DISTINCT agent_code, ord_amount,cust_code  
\end_layout

\begin_layout Plain Layout

FROM orders   
\end_layout

\end_inset


\end_layout

\begin_layout Standard
BUT in SAS SQL: be careful
\end_layout

\begin_layout Standard
Show the unique matched observation between
\end_layout

\begin_layout Standard
proc sql;
\end_layout

\begin_layout Standard
select 
\series bold
distinct
\series default
 flightnumber, destination
\end_layout

\begin_layout Standard
from sasuser.internationalflights as A
\end_layout

\begin_layout Standard
order by 1;
\end_layout

\begin_layout Standard
WATCH OUT: distinct is flightnumber AND destination 's distinct combination，而是所有
A table中的variable的distinct组合！
\end_layout

\begin_layout Standard
若想找 flightnumber 和destination的distinct组合，还是要先写一个derived table。
\end_layout

\begin_layout Standard
proc sql;
\end_layout

\begin_layout Standard
select 
\series bold
distinct
\series default
 *
\end_layout

\begin_layout Standard
from (Select flightnumber, destination
\end_layout

\begin_layout Standard
from sasuser.internationalflights as A)
\end_layout

\begin_layout Standard
quit;
\end_layout

\begin_layout Section
Group by:
\end_layout

\begin_layout Standard
Use after WHERE, before HAVING.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Group by A, B,C
\end_layout

\end_inset


\end_layout

\begin_layout Standard
means make observations with unique values of A, B ,C as a single group.
\end_layout

\begin_layout Standard
We call A, B, C as key variables..
\end_layout

\begin_layout Itemize
Principle
\end_layout

\begin_deeper
\begin_layout Itemize
When ise GROUP BY., for non-key variables, must apply summary calculation
 on it
\end_layout

\begin_layout Itemize
Cannot use summary calculation without GROUP BY.
\end_layout

\end_deeper
\begin_layout Subsection
No Calculation Action in Group By
\end_layout

\begin_layout Standard
If you do no calculations in select, like Select *, then group has no effect!!!
 Group is only used for calculation for non-key variables in that group.
\end_layout

\begin_layout Standard
For example:
\end_layout

\begin_layout Itemize
For each A-B-C group, we may also have non-key variables, like D and E.
 You have to do calculations on D and E, or calculation on total such as
 COUNT(*), SUM(1).
 Otherwise you will get Weird Results:
\end_layout

\begin_layout Itemize
If D and E all have multiple observations (not necessarily different values,
 can be same values, just repeating) in that group, then select * will keep
 those multiple observations.
\end_layout

\begin_layout Standard
所以 一般建议施加CALCULATION ON all selected non-key variables.
\end_layout

\begin_layout Subsubsection
Group by without calculation
\end_layout

\begin_layout Standard
Data: responder3
\end_layout

\begin_layout Standard
\begin_inset Tabular
<lyxtabular version="3" rows="5" columns="5">
<features rotate="0" booktabs="true" islongtable="true" longtabularalignment="center">
<column alignment="none" valignment="top" special="@{}l">
<column alignment="left" valignment="top">
<column alignment="left" valignment="top">
<column alignment="left" valignment="top">
<column alignment="none" valignment="top" special="l@{}">
<row endhead="true">
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
SEGMENT 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
BALCON_RATE 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
OFFER_NAME 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
AFFINIUM_CELL_CODE 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
OFFER_TIME
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
HB Risk Tier 1 (5% BT Fee) 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
0 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
M1C12 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
A000078900 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
201103
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
HB Risk Tier 1 (5% BT Fee) 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
0 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
M1C12 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
A000078901 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
201103
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
LB NonTransactor Tier 1 (5% BT Fee) 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
0 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
M1C12 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
A000078903 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
201103
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" bottomline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
LB NonTransactor Tier 1 (5% BT Fee) 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" bottomline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
0 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" bottomline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
M1C12 
\end_layout

\end_inset
</cell>
<cell alignment="left" valignment="top" bottomline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
A000078810 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" bottomline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
201103
\end_layout

\end_inset
</cell>
</row>
</lyxtabular>

\end_inset


\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create table Responders3 as
\end_layout

\begin_layout Plain Layout

select offer_name
\end_layout

\begin_layout Plain Layout

from Responders3
\end_layout

\begin_layout Plain Layout

group by offer_name
\end_layout

\begin_layout Plain Layout

;
\end_layout

\begin_layout Plain Layout

quit;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
OFFER_NAME
\end_layout

\begin_layout Standard
M1C12
\end_layout

\begin_layout Standard
M1C12
\end_layout

\begin_layout Standard
M1C12
\end_layout

\begin_layout Standard
M1C12
\end_layout

\begin_layout Standard

\series bold
To make offer_name unqiue, we should apply some calculation
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create table Responders3 as
\end_layout

\begin_layout Plain Layout

select offer_name, max(OFFER_TIME) as OFFER_TIME
\end_layout

\begin_layout Plain Layout

from Responders3
\end_layout

\begin_layout Plain Layout

group by offer_name
\end_layout

\begin_layout Plain Layout

;
\end_layout

\begin_layout Plain Layout

quit;
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

# result
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

OFFER_NAME OFFER_TIME
\end_layout

\begin_layout Plain Layout

M1C12 201103
\end_layout

\begin_layout Plain Layout

\end_layout

\end_inset


\end_layout

\begin_layout Paragraph
Another Example
\end_layout

\begin_layout Standard
If you use select sum(D), E.
 Then you will get no.
 of E's observations, where sum(D) is repeating.
 If you use sum(D), sum(E), then you will get an unique observation.
\end_layout

\begin_layout Standard
So for non_key variables like E, you have to apply some aggregate calculation,
 otherwise they will repeat the values of SUM(D) and 
\series bold
distinct E 
\series default
within a group by the number of distinct E times.
\end_layout

\begin_layout Subsection
Calculation without GROUP BY
\end_layout

\begin_layout Standard
Weired behavior.
\end_layout

\begin_layout Subsubsection
CASE WHEN with GROUP BY
\end_layout

\begin_layout Standard
If the data structure is
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

ID month_end sgmnt_cd tot_opn_bal_amt
\end_layout

\begin_layout Plain Layout

# 201201 CA 2
\end_layout

\begin_layout Plain Layout

# 201201 PR 100
\end_layout

\end_inset


\end_layout

\begin_layout Standard
Within If group by AF.ID, AF.month_end, then you cannot simply write
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

case when p.sgmnt_cd='PR' then p.tot_opn_bal_amt else 0 end as ..
\end_layout

\end_inset


\end_layout

\begin_layout Standard
you have to write
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

sum(case when p.sgmnt_cd='PR' then p.tot_opn_bal_amt else 0 end as ..)
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Missing Values in Group_by keys
\end_layout

\begin_layout Standard
Then the missing vlaue NULL will be a separat group.
\end_layout

\begin_layout Section
Operators 
\end_layout

\begin_layout Standard
Can be used in any EXPRESSION (SELECT or WHERE， HAVING，GROUP BY )
\end_layout

\begin_layout Standard
\begin_inset Tabular
<lyxtabular version="3" rows="10" columns="2">
<features rotate="0" booktabs="true" islongtable="true" longtabularalignment="center">
<column alignment="none" valignment="top" special="@{}l">
<column alignment="none" valignment="top" special="l@{}">
<row endhead="true">
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout

\series bold
Operator
\series default
 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout

\series bold
Description
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
= 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" topline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Equal
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
<>
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Not equal.
 
\series bold
Note:
\series default
 In some versions of SQL this operator may be written as !=
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
>
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Greater than
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
<
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Less than
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
>=
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Greater than or equal
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
<=
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Less than or equal
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
BETWEEN 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Between an inclusive range
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
LIKE 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
Search for a pattern
\end_layout

\end_inset
</cell>
</row>
<row>
<cell alignment="none" valignment="top" bottomline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
IN 
\end_layout

\end_inset
</cell>
<cell alignment="none" valignment="top" bottomline="true" usebox="none">
\begin_inset Text

\begin_layout Plain Layout
To specify multiple possible values for a column
\end_layout

\end_inset
</cell>
</row>
</lyxtabular>

\end_inset


\end_layout

\begin_layout Subsubsection
IN
\end_layout

\begin_layout Itemize
WHERE column_name IN (value1,value2,...); 
\end_layout

\begin_layout Itemize
CASE WHEN \SpecialChar \ldots{}
 IN (`1','2') THEN 
\end_layout

\begin_layout Standard

\series bold
NOT IN
\end_layout

\begin_layout Standard
BR_CODE NOT IN ('S','B3','B4','SS','SF','S0')
\end_layout

\begin_layout Standard
THERE IS NO 
\begin_inset Quotes eld
\end_inset

IS
\begin_inset Quotes erd
\end_inset

 FOR IN.
\end_layout

\begin_layout Subsubsection
BETWEEN\SpecialChar \ldots{}
 AND
\end_layout

\begin_layout Standard
BETWEEN includes the range boundaries
\end_layout

\begin_layout Standard
where t.post_dt between &day and &day1
\end_layout

\begin_layout Standard
Between can even be used in 
\series bold
character
\end_layout

\begin_layout Standard
BETWEEN `D ' AND `D99' /*choose all `D ', then `D01' to `D99'*/
\end_layout

\begin_layout Standard
另一种方便法
\end_layout

\begin_layout Standard
if 750 <=totaltime <= 800 then TestLength='Normal';
\end_layout

\begin_layout Standard

\series bold
NOT BETWEEN
\end_layout

\begin_layout Standard
Thus choose range beyond.
\end_layout

\begin_layout Subsubsection
CONTAINS
\end_layout

\begin_layout Standard
WHERE Region CONTAINS 'ain'; 
\end_layout

\begin_layout Subsubsection
LIKE
\end_layout

\begin_layout Standard
后接正则表达式，用于specify strings that satisfy the regular expression you provide.
\end_layout

\begin_layout Standard
%
\end_layout

\begin_layout Subsubsection
IS NULL and IS NOT NULL
\begin_inset space ~
\end_inset


\end_layout

\begin_layout Standard
To decide whether variable value is missing
\end_layout

\begin_layout Standard
Cannot be used in HAVING
\end_layout

\begin_layout Part
Basic Techs
\end_layout

\begin_layout Section
Bascis
\end_layout

\begin_layout Subsection
好的SQL编程习惯
\end_layout

\begin_layout Standard
SELECT 中的每一个variable前都要加 library.
 ,以便知道这个vairable来自于FROM、JOIN中的哪一个table。
\end_layout

\begin_layout Subsection
as: Specifying a Table Alias/change output variable name
\end_layout

\begin_layout Standard
It can be difficult to read PROC SQL code that contains lengthy qualified
 column names.
 In addition, typing (and retyping) long table names can be time-consuming.
 Fortunately, you can use a temporary, alternate name for any or all tables
 in any PROC SQL query.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

title 'Employee Names and Job Codes';
\end_layout

\begin_layout Plain Layout

select s.empid as A, lastname, firstname, jobcode
\end_layout

\begin_layout Plain Layout

from sasuser.staffmaster as s,
\end_layout

\begin_layout Plain Layout

sasuser.payrollmaster as p
\end_layout

\begin_layout Plain Layout

where s.empid=p.empid;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
NULL
\end_layout

\begin_layout Standard
NULL is treated as negative infinity if variable is numeric.
\end_layout

\begin_layout Standard
So
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Where A<=10
\end_layout

\end_inset


\end_layout

\begin_layout Standard
Will include all NULL values in A
\end_layout

\begin_layout Subsection
.* / * Choose 
\end_layout

\begin_layout Itemize
Choose all variables in select: *
\end_layout

\begin_layout Itemize
Choose all variables in table A: A.*
\end_layout

\begin_layout Subsection
Rename Column: Label/AS/In_Line_view
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select count(*) label='No.
 of Persons'
\end_layout

\end_inset


\end_layout

\begin_layout Standard
If a variable is from a calculated result, then you have to rename it with
 as, otherwise there is an error:
\end_layout

\begin_layout Standard
This will not work, as no name!
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SUM(credit_limit)
\end_layout

\end_inset


\end_layout

\begin_layout Standard
The statement does not include a required column list.
\end_layout

\begin_layout Standard
This will work
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SUM(credit_limit) as credit_limit,
\end_layout

\end_inset


\end_layout

\begin_layout Standard
To create a temporary table using in Proc SQL..
 FROM.
 You should define all the variables in in-line table using alas, and you
 can refer those alas in main PROC SQL statement.
\end_layout

\begin_layout Standard

\series bold
To join multiple tables, you can even write multi-level in-line View.
\end_layout

\begin_layout Standard
proc sql;
\end_layout

\begin_layout Standard
title "Flight Destinations and Delays";
\end_layout

\begin_layout Standard
select destination,
\end_layout

\begin_layout Standard
average format=3.0 label='Average Delay',
\end_layout

\begin_layout Standard
max format=3.0 label='Maximum Delay',
\end_layout

\begin_layout Standard

\series bold
late
\series default
/(late+early) as prob format=5.2
\end_layout

\begin_layout Standard
label='Probability of Delay'
\end_layout

\begin_layout Quote
from 
\series bold
(select destination,
\end_layout

\begin_layout Quote

\series bold
avg(delay) as average,
\end_layout

\begin_layout Quote

\series bold
max(delay) as max,
\end_layout

\begin_layout Quote

\series bold
sum(delay 
\begin_inset ERT
status collapsed

\begin_layout Plain Layout


\backslash
textgreater
\end_layout

\end_inset


\begin_inset ERT
status collapsed

\begin_layout Plain Layout

{}
\end_layout

\end_inset

 0) as late,
\end_layout

\begin_layout Quote

\series bold
sum(delay 
\begin_inset ERT
status collapsed

\begin_layout Plain Layout


\backslash
textless
\end_layout

\end_inset


\begin_inset ERT
status collapsed

\begin_layout Plain Layout

{}
\end_layout

\end_inset

= 0) as early
\end_layout

\begin_layout Quote

\series bold
from sasuser.flightdelays
\end_layout

\begin_layout Quote

\series bold
group by destination)
\series default
 
\end_layout

\begin_layout Standard
order by average;
\end_layout

\begin_layout Subsection
Count
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

count ( *) # is wrong
\end_layout

\begin_layout Plain Layout

count( *) # is correct
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
The COUNT(column_name) function returns the number of values (NULL values
 will not be counted) of the specified column:
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

The COUNT(DISTINCT column_name) 
\end_layout

\end_inset

function returns the number of distinct values of the specified column:
\end_layout

\begin_layout Itemize
The COUNT(*) function returns the number of records in a table:
\end_layout

\begin_layout Subsection
Use of 
\begin_inset Quotes eld
\end_inset

;
\begin_inset Quotes erd
\end_inset


\end_layout

\begin_layout Itemize

\series bold
To end Single Sentence
\series default
 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

options compress=binary obs=max;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

libname out '/sasusr/saswork/Fan_Yang/';
\end_layout

\end_inset


\end_layout

\begin_layout Itemize

\series bold
multiple actions in SQL
\series default
 
\end_layout

\begin_layout Standard
after
\end_layout

\begin_layout Enumerate
proc sql; 
\end_layout

\begin_layout Enumerate
connection; 
\end_layout

\begin_layout Enumerate
main code; 
\end_layout

\begin_layout Enumerate
and quit; 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

PROC SQL;
\end_layout

\begin_layout Plain Layout

CONNECT TO DB2(DATABASE=fnndw5);
\end_layout

\begin_layout Plain Layout

DROP TABLE db2lib.BT_Cycle_Summary;
\end_layout

\begin_layout Plain Layout

group by acct_nbr,cycle_end) AS BT;
\end_layout

\begin_layout Plain Layout

quit;
\end_layout

\end_inset


\end_layout

\begin_layout Itemize

\series bold
In macro
\series default
 
\end_layout

\begin_layout Standard

\series bold
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

%MACRO Final_Total(start,ending);
\end_layout

\begin_layout Plain Layout

%do Vintage=&start %to &ending;
\end_layout

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

CONNECT TO DB2(DATABASE=fnndw4);
\end_layout

\begin_layout Plain Layout

drop table db2lib.perfor12,db2lib.perfor13;
\end_layout

\begin_layout Plain Layout

quit;
\end_layout

\begin_layout Plain Layout

%Performance(12,&Vintage)
\end_layout

\begin_layout Plain Layout

%Performance(13,&Vintage)
\end_layout

\begin_layout Plain Layout

%Final(&Vintage);
\end_layout

\begin_layout Plain Layout

%end;
\end_layout

\begin_layout Plain Layout

%mend;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
CALCULATED VARIABLE
\end_layout

\begin_layout Standard
CALCULATED variable.
 IE:
\end_layout

\begin_layout Standard
建议将 CALCULATED variable 用括号括住，以区分 keyword那个variable本身。
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select age*2 as double_Age, 
\end_layout

\begin_layout Plain Layout

(calculated double_age)/2 as normal_age from sashelp.class;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
ASCII
\end_layout

\begin_layout Standard
/*Generate offer time,using ASCII.
 A means Jan, B means Feb.....
\end_layout

\begin_layout Standard
ASCII FUNCTION CAN ONLY WORK WITHIN DB2*/
\end_layout

\begin_layout Standard

\series bold
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

CONNECT TO DB2(DATABaSE=fnndw4);
\end_layout

\begin_layout Plain Layout

create table out.Offer_BT_2011_2013 as
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from connection to DB2(
\end_layout

\begin_layout Plain Layout

	select substr(AFFINIUM_CELL_CODE,1,10) AS AFFINIUM_CELL_CODE,
\end_layout

\begin_layout Plain Layout

	MAIN.*,
\end_layout

\begin_layout Plain Layout

	CASE WHEN substr(Offer_Name,2,1) IN ('0','1','2','3','4','5','6','7' /*Welcome
 to 2017*/) and (ASCII(substr(Offer_Name,3,1))-64)=12
\end_layout

\begin_layout Plain Layout

		THEN (INTEGER(substr(Offer_Name,2,1))+2010)*100+ ASCII(substr(Offer_Name,3,1))
-64
\end_layout

\begin_layout Plain Layout

		else 204604
\end_layout

\begin_layout Plain Layout

		end as offer_time
\end_layout

\begin_layout Plain Layout

	from u338194.Offer_BT_2011_2013 AS MAIN
\end_layout

\begin_layout Plain Layout

	WHERE AFFINIUM_CELL_CODE IS NOT NULL);
\end_layout

\begin_layout Plain Layout

quit;
\end_layout

\end_inset


\end_layout

\begin_layout Section
Duplication
\end_layout

\begin_layout Subsection
Duplicate variables in DB2
\end_layout

\begin_layout Standard
If both a and b contains the same variable, then the output will only use
 A's variable
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Proc sql;
\end_layout

\begin_layout Plain Layout

Select a.* , b.*
\end_layout

\begin_layout Plain Layout

From a
\end_layout

\begin_layout Plain Layout

Left join b
\end_layout

\begin_layout Plain Layout

On .;
\end_layout

\begin_layout Plain Layout

Quit;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Identify duplicate rows 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select o.orgName, oc.dupeCount, o.id
\end_layout

\begin_layout Plain Layout

from organizations o
\end_layout

\begin_layout Plain Layout

inner join (
\end_layout

\begin_layout Plain Layout

	SELECT orgName, COUNT(*) AS dupeCount
\end_layout

\begin_layout Plain Layout

	FROM organizations
\end_layout

\begin_layout Plain Layout

	GROUP BY orgName
\end_layout

\begin_layout Plain Layout

	HAVING COUNT(*)
\end_layout

\begin_layout Plain Layout

	) 
\end_layout

\begin_layout Plain Layout

oc on o.orgName = oc.orgName
\end_layout

\end_inset


\end_layout

\begin_layout Section
Scalar function
\end_layout

\begin_layout Standard
A build in Scalar function can be used directly in expression.
\end_layout

\begin_layout Itemize
DECIMAL, MONTH, YEAR\SpecialChar \ldots{}
.
\end_layout

\begin_layout Itemize
CORRELATION(variable1, variable2)
\end_layout

\begin_layout Itemize
COVARIANCE(variable1, variable2)
\end_layout

\begin_layout Itemize
STDDEV
\end_layout

\begin_layout Itemize
RAND # Random numbers
\end_layout

\begin_layout Itemize
QUARTER(Date) # return which quarter of the date in a year.
\end_layout

\begin_layout Section
Duration/Calculation of time
\end_layout

\begin_layout Standard
+ or -- on any data/time/time_stamp data types
\end_layout

\begin_layout Subsection
default variable / Special register
\end_layout

\begin_layout Standard
系统中中default variable，如调用当前系统时间 CURRENT------DATE。
\end_layout

\begin_layout Part
Structure
\end_layout

\begin_layout Subsection
Correlated subquery 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT employee_number, name
\end_layout

\begin_layout Plain Layout

FROM employees AS Bob
\end_layout

\begin_layout Plain Layout

WHERE salary >=
\end_layout

\begin_layout Plain Layout

	( SELECT AVG(salary)
\end_layout

\begin_layout Plain Layout

	FROM employees
\end_layout

\begin_layout Plain Layout

	WHERE department = Bob.department);
\end_layout

\end_inset


\end_layout

\begin_layout Standard
In the above nested query the inner query has to be re-executed for each
 employee
\end_layout

\begin_layout Standard
一般避免correlated subquery， 因其逻辑模糊，编的不好往往影响效率。用JOIN可替代correlated subquery。JOIN
 逻辑清晰，亦写对。
\end_layout

\begin_layout Subsection
Sub-query
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select jobcode,
\end_layout

\begin_layout Plain Layout

	avg(salary) as AvgSalary
\end_layout

\begin_layout Plain Layout

	format=dollar11.2
\end_layout

\begin_layout Plain Layout

from sasuser.payrollmaster
\end_layout

\begin_layout Plain Layout

group by jobcode
\end_layout

\begin_layout Plain Layout

having avg(salary) >= (
\end_layout

\begin_layout Quote

select avg(salary)
\end_layout

\begin_layout Quote

from sasuser.payrollmaster); 
\end_layout

\end_inset


\end_layout

\begin_layout Itemize

\series bold
\emph on
Tip:
\emph default
 It is recommended that you enclose a subquery (inner query) in parentheses,
 as shown here.
\end_layout

\begin_layout Standard
Sub-query/sub-select Is always part of the 
\series bold
predicate
\end_layout

\begin_layout Standard

\series bold
Must only produce one column data
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Where salary in (select Wage from A)
\end_layout

\end_inset


\end_layout

\begin_layout Standard
OR
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT A, (SELECT WAGE FROM DATA_A) ,B
\end_layout

\begin_layout Plain Layout

FROM ..
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
ALL, ANY, SOME, IN, EXISTS.
 For subquaery
\end_layout

\begin_layout Itemize
WHERE Expression > ALL (subquery) 
\end_layout

\begin_layout Itemize
WHERE Expression > ANY (subquery) 
\end_layout

\begin_layout Itemize
WHERE A IN is the same as `=ANY' or `SOME' 
\end_layout

\begin_layout Itemize
WHERE (NOT) EXISTS (subquery)
\end_layout

\begin_deeper
\begin_layout Itemize
If the sub-query at least return one row, then it is TRUE.
 Otherwise FALSE.
 
\end_layout

\end_deeper
\begin_layout Subsection
With: detached table 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

PROC SQL;
\end_layout

\begin_layout Plain Layout

CONNECT TO DB2(DATABASE=fnndw5);
\end_layout

\begin_layout Plain Layout

create table out.&Name as
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from connection to db2(
\end_layout

\begin_layout Plain Layout

	＃use with to begin the detached table
\end_layout

\begin_layout Quote

with 
\end_layout

\begin_layout Plain Layout

	＃First detached table
\end_layout

\begin_layout Quote

A as(
\end_layout

\begin_layout Quote

	select * from
\end_layout

\begin_layout Quote

), ＃ detached table ends with ",", and then start with a new detached table
\end_layout

\begin_layout Plain Layout

	＃ second detached table
\end_layout

\begin_layout Quote

B AS (
\end_layout

\begin_layout Quote

SELECT
\end_layout

\begin_layout Quote

) ＃when all the detached table ends, no ","
\end_layout

\begin_layout Plain Layout

# 主！
\end_layout

\begin_layout Plain Layout

Select * from A LEFT JOIN B ＃主table可以从副table A，和B中取data
\end_layout

\begin_layout Plain Layout

);
\end_layout

\begin_layout Plain Layout

quit;
\end_layout

\end_inset


\end_layout

\begin_layout Section
Views
\end_layout

\begin_layout Standard

\series bold
sasuser.raisev
\series default
 is the view you create and can be used later.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create view sasuser.raisev as
\end_layout

\begin_layout Plain Layout

select empid, jobcode,
\end_layout

\begin_layout Plain Layout

	salary format=dollar12.2,
\end_layout

\begin_layout Plain Layout

	salary/12 as MonthlySalary
\end_layout

\begin_layout Plain Layout

format=dollar12.
\end_layout

\begin_layout Plain Layout

from payrollmaster;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from sasuser.raise
\end_layout

\begin_layout Plain Layout

where jobcode in ('PT2','PT3');
\end_layout

\end_inset


\end_layout

\begin_layout Standard
PROC SQL views
\end_layout

\begin_layout Itemize
can be used in SAS programs in place of an actual SAS data file 
\end_layout

\begin_layout Itemize
can be joined with tables or other views 
\end_layout

\begin_layout Itemize
can be derived from one or more tables, PROC SQL views, or DATA step views
 
\end_layout

\begin_layout Itemize
can access data from a SAS data set, a DATA step view, a PROC SQL view,
 or a relational database table 
\end_layout

\begin_layout Itemize
extract underlying data, which enables you to access the most current data.
 
\end_layout

\begin_layout Standard
Views are useful because they
\end_layout

\begin_layout Itemize
Often save space (a view is usually quite small compared with the data that
 it accesses) 
\end_layout

\begin_layout Itemize
Prevent users from continually submitting queries to omit unwanted columns
 or rows 
\end_layout

\begin_layout Itemize
Ensure that input data sets are always current, because data is derived
 from tables at execution time 
\end_layout

\begin_layout Itemize
Shield sensitive or confidential columns from users while enabling the same
 users to view other columns in the same table 
\end_layout

\begin_layout Itemize
Hide complex joins or queries from users.
 
\end_layout

\begin_layout Subsubsection
Creating/Drop PROC SQL Views
\end_layout

\begin_layout Standard
proc sql;
\end_layout

\begin_layout Standard
drop view sasuser.raisev;
\end_layout

\begin_layout Subsubsection
Display Views
\end_layout

\begin_layout Standard
proc sql;
\end_layout

\begin_layout Standard
describe view sasuser.faview;
\end_layout

\begin_layout Subsubsection
Tips in using VIEWS 
\end_layout

\begin_layout Itemize
Avoid using an ORDER BY clause in a view definition, which causes the data
 to be sorted every time the view is executed.
 Users of the view might differ in how or whether they want the data to
 be sorted, so it is more efficient to specify an ORDER BY clause in a query
 that references the view.
 
\end_layout

\begin_layout Itemize
If the same data is used many times in one program or in multiple programs,
 it is more efficient to create a table rather than a view because the data
 must be accessed at each view reference.
 
\end_layout

\begin_layout Itemize
If a view resides in the same SAS data library as the contributing table(s),
 it is best to specify a one-level name in the FROM clause.
 it isn't necessary to 
\series bold
specify the libref 
\emph on
Sasuser
\emph default
 because the contributing table is assumed to be stored in the same library
 as the view.

\series default
 
\end_layout

\begin_layout Subsubsection
Subquery returns multiple values:
\end_layout

\begin_layout Standard

\series bold
ANY
\series default
: When a subquery might return multiple values, you must use one of the
 conditional operators ANY or ALL to modify a comparison operator in the
 WHERE or HAVING clause immediately before the subquery.
\end_layout

\begin_layout Standard
where dateofbirth <= any
\end_layout

\begin_layout Standard

\series bold
ALL
\series default
: An outer query that specifies the ALL operator selects values that pass
 the comparison test with 
\emph on
all
\emph default
 of the values that are returned by the subquery.
\end_layout

\begin_layout Part
Bugs & Error
\end_layout

\begin_layout Subsection
An arithmetic overflow
\end_layout

\begin_layout Standard
Happen when apply any calculation into infinity values and huge values beyond
 system ability.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Sum(af.credit_limit) as credit_limit 
\end_layout

\end_inset


\end_layout

\begin_layout Standard
will result in 
\series bold
arithmetic overflow
\series default
 error.
\end_layout

\begin_layout Standard
Id there are infinity values in 
\series bold
af.credit_limit
\series default
.
 So the way to solve this is first select all 
\series bold
af.credit_limit and then see the actual range of it.
 Then use where condition to restrict the sum calculation
\end_layout

\begin_layout Standard

\series bold
If total sum value is too big, then divide it by some 10^6 to make it small.
\end_layout

\begin_layout Subsection
Ambiguous Columns
\end_layout

\begin_layout Standard
如下，若A 和B 都存在同一个名为VA的variable，则出现error: Ambiguous Columns.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

Select VA
\end_layout

\begin_layout Plain Layout

From ..
 as A
\end_layout

\begin_layout Plain Layout

Left join .
 As B
\end_layout

\begin_layout Plain Layout

On .
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
缺逗号
\end_layout

\begin_layout Standard
下文中A后应有逗号，B后应无逗号。
\end_layout

\begin_layout Standard
最常出现的error。Error不会告诉你错是啥，只是很复杂。
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select A
\end_layout

\begin_layout Plain Layout

B,
\end_layout

\begin_layout Plain Layout

FROM。。。
\end_layout

\end_inset


\end_layout

\begin_layout Subsubsection
JOIN 缺 ON
\end_layout

\begin_layout Standard
同样：Error不会告诉你错是啥，只是很复杂。
\end_layout

\begin_layout Part
Join and Union and Modify
\end_layout

\begin_layout Section
JOIN
\end_layout

\begin_layout Standard
Join Table：Combine Tables Horizontally
\end_layout

\begin_layout Subsection
Left/Right Outer Join
\end_layout

\begin_layout Standard
极重要
\end_layout

\begin_layout Standard
A left outer join retrieves 
\emph on
all rows that match across tables
\emph default
, based on the specified matching criteria (join conditions), plus 
\emph on
nonmatching rows from the left table
\emph default
 (the 
\emph on
first
\emph default
 table specified in the FROM clause).同理 有right join
\end_layout

\begin_layout Itemize
Treat the table with all the rows you want all keep as the Left Table 
\end_layout

\begin_layout Standard

\series bold
Strange Behavior
\end_layout

\begin_layout Itemize
Left Join 若左column X仅有K个row，而又有相对应的N row, （N为K的倍数） 则left join 后为column X那个Row重复N
次，成为N＊K个row。 
\end_layout

\begin_deeper
\begin_layout Itemize
So, any join will change the original corresponding structure of key variables
 in left table, as those key variables will 重复N次，成为N＊K个row.
 So be careful when you use sum() when JOIN is there.
 
\end_layout

\end_deeper
\begin_layout Itemize
For key variables, you have to choose ones in LEFT table, OR if there is
 full join, you have to choose key variables from the FULL JOIN TABLE.
 Otherwise there might be NULL in key variables.
 
\end_layout

\begin_deeper
\begin_layout Itemize
Key variables in SELECT must be key variables in GROUP and ORDER.
 Often we should treat key variables in left table as key variables in SELECT.
 
\end_layout

\begin_layout Itemize
For ON, you can only write right.key=left.key, you can not not write right.key=key_
value, which means you cannot treat the ON as WHERE.
 
\series bold
Otherwise it is super SLOW.
 
\end_layout

\end_deeper
\begin_layout Itemize
Be really careful when you put WHERE restriction on the variables of right
 table in the suface layer.
 It is much safer to put it in the subquery.
 See the difference in behavior below.
\end_layout

\begin_deeper
\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

select 
\end_layout

\begin_layout Plain Layout

  e.id,
\end_layout

\begin_layout Plain Layout

  ep.employee_id,
\end_layout

\begin_layout Plain Layout

  e.*
\end_layout

\begin_layout Plain Layout

  
\end_layout

\begin_layout Plain Layout

from employees as e
\end_layout

\begin_layout Plain Layout

  
\end_layout

\begin_layout Plain Layout

  left join (
\end_layout

\begin_layout Plain Layout

    select ep.* 
\end_layout

\begin_layout Plain Layout

    from employees_projects as ep
\end_layout

\begin_layout Plain Layout

    where ep.employee_id> 3
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

  ) as ep
\end_layout

\begin_layout Plain Layout

  on e.id = ep.employee_id
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

+----+-------------+----+------------+-----------+--------+--------------
\end_layout

\begin_layout Plain Layout

-+ 
\end_layout

\begin_layout Plain Layout

| id | employee_id | id | first_name | last_name | salary | department_id
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

+----+-------------+----+------------+-----------+--------+--------------
\end_layout

\begin_layout Plain Layout

-+ 
\end_layout

\begin_layout Plain Layout

|  1 |        NULL |  1 | John       | Smith     |  20000 |            
 1
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

|  2 |        NULL |  2 | Ava        | Muffinson |  10000 |            
 5
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

|  3 |        NULL |  3 | Cailin     | Ninson    |  30000 |            
 2
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

|  4 |           4 |  4 | Mike       | Peterson  |  20000 |            
 2
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

|  5 |           5 |  5 | Ian        | Peterson  |  80000 |            
 2
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

|  6 |        NULL |  6 | John       | Mills     |  50000 |            
 3
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

+----+-------------+----+------------+-----------+--------+--------------
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select 
\end_layout

\begin_layout Plain Layout

  e.id, 
\end_layout

\begin_layout Plain Layout

  ep.employee_id, 
\end_layout

\begin_layout Plain Layout

  e.* 
\end_layout

\begin_layout Plain Layout

 
\end_layout

\begin_layout Plain Layout

from employees as e 
\end_layout

\begin_layout Plain Layout

  left join employees_projects as ep 
\end_layout

\begin_layout Plain Layout

    on e.id = ep.employee_id 
\end_layout

\begin_layout Plain Layout

    where ep.employee_id> 3 
\end_layout

\begin_layout Plain Layout

-------------- 
\end_layout

\begin_layout Plain Layout

 
\end_layout

\begin_layout Plain Layout

+----+-------------+----+------------+-----------+--------+--------------
\end_layout

\begin_layout Plain Layout

-+ 
\end_layout

\begin_layout Plain Layout

| id | employee_id | id | first_name | last_name | salary | department_id
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

+----+-------------+----+------------+-----------+--------+--------------
\end_layout

\begin_layout Plain Layout

-+ 
\end_layout

\begin_layout Plain Layout

|  4 |           4 |  4 | Mike       | Peterson  |  20000 |            
 2
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

|  5 |           5 |  5 | Ian        | Peterson  |  80000 |            
 2
\end_layout

\begin_layout Plain Layout

 | 
\end_layout

\begin_layout Plain Layout

+----+-------------+----+------------+-----------+--------+--------------
\end_layout

\begin_layout Plain Layout

-+ 
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Left Join中，right table 若为 left table 的 subset, then if you put a RESTRICTION
 on WHERE for right table, then there might be no null in the variable of
 right table with restriction, which means you treat right table as the
 key table.
 
\end_layout

\end_deeper
\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one
\end_layout

\begin_layout Plain Layout

left join
\end_layout

\begin_layout Plain Layout

two
\end_layout

\begin_layout Plain Layout

on one.x=two.x;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Full join 
\end_layout

\begin_layout Standard
The FULL OUTER JOIN keyword returns all rows from the left table (table1)
 and from the right table (table2).
 The FULL OUTER JOIN keyword combines the result of both LEFT and RIGHT
 joins.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one
\end_layout

\begin_layout Plain Layout

full join
\end_layout

\begin_layout Plain Layout

two
\end_layout

\begin_layout Plain Layout

on one.x=two.x;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Coalesce in Full Join
\end_layout

\begin_layout Standard
Evaluates the arguments in order and returns the current value of the first
 expression that initially does not evaluate to NULL.
\end_layout

\begin_layout Standard
COALESCE (expr1, expr2)
\end_layout

\begin_layout Standard
is equivalent to:
\end_layout

\begin_layout Standard
CASE WHEN expr1 IS NOT NULL THEN expr1 ELSE expr2 END
\end_layout

\begin_layout Standard
Similarly,
\end_layout

\begin_layout Standard
COALESCE (expr1, expr2, ..., exprn), for n>=3
\end_layout

\begin_layout Standard
is equivalent to:
\end_layout

\begin_layout Standard
CASE WHEN expr1 IS NOT NULL THEN expr1 ELSE COALESCE (expr2, ..., exprn) END
 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

title 'Table Merged';
\end_layout

\begin_layout Plain Layout

select coalesce(three.x, four.x) as X, a, b
\end_layout

\begin_layout Plain Layout

from three
\end_layout

\begin_layout Plain Layout

full join
\end_layout

\begin_layout Plain Layout

four
\end_layout

\begin_layout Plain Layout

on three.x = four.x;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
老方法
\end_layout

\begin_layout Subsubsection
Any combination 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one, two;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
The output shown above displays all possible combinations of each row in
 table 
\emph on
One
\emph default
 with all rows in table 
\emph on
Two.
 That means
\emph default
 returns a Cartesian.
\end_layout

\begin_layout Subsubsection
Matched Merge
\end_layout

\begin_layout Standard
老方法，不清晰，不要用。
\end_layout

\begin_layout Standard

\emph on
Note:
\emph default
 An inner join is sometimes called a 
\emph on
conventional join
\emph default
.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one, two
\end_layout

\begin_layout Plain Layout

where one.x = two.x;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
The WHERE clause expression (join condition) specifies that the result set
 should include only rows whose values of column 
\series bold
X
\series default
 in the table 
\emph on
One
\emph default
 are 
\emph on
equal to
\emph default
 values in column 
\series bold
X
\series default
 of the table 
\emph on
Two
\emph default
.
\end_layout

\begin_layout Standard
To eliminate a duplicate column: two variables named as x:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql; 
\end_layout

\begin_layout Plain Layout

select one.x as ID , a, b % as ID to rename
\end_layout

\begin_layout Plain Layout

from one, two
\end_layout

\begin_layout Plain Layout

where one.x = two.x
\end_layout

\end_inset


\end_layout

\begin_layout Subsubsection
join multiple tables
\end_layout

\begin_layout Standard
此下写法为老写法 现在不推荐了。
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select distinct e.firstname, e.lastname
\end_layout

\begin_layout Plain Layout

from sasuser.flightschedule as a,
\end_layout

\begin_layout Plain Layout

sasuser.staffmaster as b,
\end_layout

\begin_layout Plain Layout

sasuser.payrollmaster as c,
\end_layout

\begin_layout Plain Layout

sasuser.supervisors as d,
\end_layout

\begin_layout Plain Layout

sasuser.staffmaster as e
\end_layout

\begin_layout Plain Layout

where a.date='04mar2000'd and
\end_layout

\begin_layout Plain Layout

a.destination='CPH' and
\end_layout

\begin_layout Plain Layout

a.empid=b.empid and
\end_layout

\begin_layout Plain Layout

a.empid=c.empid and
\end_layout

\begin_layout Plain Layout

d.jobcategory=substr(c.jobcode,1,2)
\end_layout

\begin_layout Plain Layout

and d.state=b.state
\end_layout

\begin_layout Plain Layout

and d.empid=e.empid;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
一般为单个table 当单个写left join, 比老写法清晰许多。
\end_layout

\begin_layout Standard
from af as main
\end_layout

\begin_layout Standard
left join dsfd as A
\end_layout

\begin_layout Standard
on A.ID=main.ID and A.month_end=main.month_end
\end_layout

\begin_layout Standard
left join fdsfs as B
\end_layout

\begin_layout Standard
on B.ID=main.ID and B.month_end=main.month_end
\end_layout

\begin_layout Section
UNION
\end_layout

\begin_layout Standard
To Combine Tables Vertically
\end_layout

\begin_layout Standard
The set operators EXCEPT, INTERSECT, and UNION overlay columns based on
 the relative 
\emph on
position
\emph default
 of the columns in the SELECT clause.
 Column names are ignored.
\end_layout

\begin_layout Standard
Duplicate rows in output are ignored.
 (The way to include them is to use ALL)
\end_layout

\begin_layout Standard

\series bold
Different Vertical Combination
\end_layout

\begin_layout Standard
\begin_inset Graphics
	filename H:/Pandoc/media/image13.png
	width 4.875in
	height 2.81384in

\end_inset


\end_layout

\begin_layout Standard
\begin_inset Graphics
	filename H:/Pandoc/media/image14.png
	width 5in
	height 2.69677in

\end_inset


\end_layout

\begin_layout Subsection
EXCEPT only
\end_layout

\begin_layout Itemize
rows: Displays the 
\series bold
\emph on
unique
\series default
\emph default
 rows in table 
\series bold
\emph on
One
\emph default
 that are 
\emph on
not
\emph default
 found in table 
\emph on
two
\series default
\emph default
.
\end_layout

\begin_layout Itemize
columns: overlay columns based on their positions in SELECT, but not their
 names
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

except
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from two;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
EXCEPT
\series bold
 ALL
\end_layout

\begin_layout Standard

\series bold
ALL
\series default
: To select 
\emph on
all rows
\emph default
 in the 
\emph on
first
\emph default
 table 
\series bold
(both unique and duplicate
\series default
) that do 
\emph on
not
\emph default
 have a matching row in the 
\emph on
second
\emph default
 table.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

except all
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from two;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection

\series bold
EXCEPT
\series default
 Corr
\end_layout

\begin_layout Standard
Add the keyword 
\emph on
CORR
\emph default
 after the set operator
\series bold
:
\series default
 
\end_layout

\begin_layout Itemize
Only columns that have the 
\series bold
\emph on
same name  
\emph default
all 
\emph on
unique rows
\series default
\emph default
 in the 
\emph on
first
\emph default
 table that do 
\emph on
not
\emph default
 appear in the 
\series bold
\emph on
second
\emph default
 table
\series default
.
\end_layout

\begin_layout Itemize
So if table A has column X and Y, and table B has X and Z, so the resulting
 table will only have column A
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one
\end_layout

\begin_layout Plain Layout

except corr
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from two;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
INTERSECT
\end_layout

\begin_layout Itemize
rows: Displays the 
\series bold
\emph on
unique
\series default
\emph default
 rows in both table
\series bold
 one and table two
\end_layout

\begin_layout Itemize
columns: overlay columns based on their positions in SELECT, but not their
 names
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one
\end_layout

\begin_layout Plain Layout

intersect
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from two;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
OUTER UNION
\end_layout

\begin_layout Itemize

\emph on
All
\emph default
 rows from 
\emph on
both
\emph default
 of the tables 
\emph on
One
\emph default
 and 
\emph on
Two
\emph default
, 
\series bold
\emph on
without overlaying
\series default
\emph default
 columns.
 
\end_layout

\begin_deeper
\begin_layout Itemize
If table 1 has X and Y, table 2 has X and Z, then the resulting table would
 be X, Y, X, Z.
\end_layout

\end_deeper
\begin_layout Itemize
Allow duplication.
 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from one
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

outer union
\end_layout

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from two;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection

\series bold
OUTER UNION CORR -- most flexible
\end_layout

\begin_layout Standard

\series bold
Difference from Outer Union: CORR in OUTER UNION Allow overlaying table,
 by variable names
\end_layout

\begin_layout Itemize
If table 1 has X and Y, table 2 has X and Z, then the resulting table would
 be X, Y, Z.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from sasuser.mechanicslevel1
\end_layout

\begin_layout Plain Layout

outer union corr
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from sasuser.mechanicslevel2
\end_layout

\begin_layout Plain Layout

outer union corr
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from sasuser.mechanicslevel3;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Key Word Summary
\end_layout

\begin_layout Itemize

\series bold
ALL -- govern the duplicated rows:
\series default
 by default duplicate rows in output are removed (except for OUTER UNION).
 ALL prevents this.
\end_layout

\begin_layout Itemize
Outer -- 
\series bold
govern both the duplicated cols and rows: 
\end_layout

\begin_deeper
\begin_layout Itemize
If there is a column in B that not eixst in A, then that column will not
 be included.
 Outer will prevent this.
\end_layout

\begin_layout Itemize
Also Outer allows duplication of rows.
\end_layout

\end_deeper
\begin_layout Itemize
CORR: by default we combine tables vertically by column position, CORR is
 force to use column's name.
 If there is only 1 name matched, then output is also 1 column.
\end_layout

\begin_deeper
\begin_layout Itemize

\series bold
CORR in OUTER UNION：Allow overlaying table, by variable names
\end_layout

\begin_layout Itemize
UNION CORR can only be used beyond db2, which means you cannot write
\end_layout

\end_deeper
\begin_layout Itemize
From connection to db2 (select * ..)
\end_layout

\begin_layout Subsection
以UNION ALL最严格
\end_layout

\begin_layout Itemize
column: UNION ALL 要求从AA，BB同时选出数量、名称、type接一样的variables。
\end_layout

\begin_layout Itemize
If there is a column in B that not eixst in A, then that column will not
 be included.
\end_layout

\begin_deeper
\begin_layout Itemize
Outer will prevent this.
\end_layout

\end_deeper
\begin_layout Itemize
rows: combine all rows in AA and BB
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

select A，B
\end_layout

\begin_layout Plain Layout

from AA
\end_layout

\begin_layout Plain Layout

UNION ALL
\end_layout

\begin_layout Plain Layout

select A，B
\end_layout

\begin_layout Plain Layout

from BB
\end_layout

\end_inset


\end_layout

\begin_layout Section
Modify
\end_layout

\begin_layout Subsection
Inserting Rows
\end_layout

\begin_layout Standard
In the second method, if insert a value for 
\emph on
all columns
\emph default
 in the table, then just:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

insert into work.newtable
\end_layout

\begin_layout Plain Layout

	values ('WI','FLUTE',6)
\end_layout

\begin_layout Plain Layout

	values ('ST','VIOLIN',3);
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Updating Values in Existing Table Rows
\end_layout

\begin_layout Subsection
delete from table: Drop Rows in a Table
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

delete from work.frequentflyers2
\end_layout

\begin_layout Plain Layout

where pointsearned-pointsused <= 0;
\end_layout

\end_inset


\end_layout

\begin_layout Standard
If you want to delete only a subset of rows in the table, you must specify
 a WHERE clause or 
\emph on
all
\emph default
 rows in the table will be deleted.
\end_layout

\begin_layout Subsection
DROP Coulumn: ALTER TABLE
\end_layout

\begin_layout Standard
Used same as SELECT column
\end_layout

\begin_layout Standard

\series bold
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

alter table work.payrollmaster4
\end_layout

\begin_layout Plain Layout

drop bonus, level;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Adding, Dropping, and Modifying Columns
\end_layout

\begin_layout Standard
Use the 
\emph on
MODIFY clause
\emph default
 in the 
\emph on
ALTER TABLE statement
\emph default
.
 You can use the MODIFY clause to change a column's
\end_layout

\begin_layout Itemize
length (column width) --- for a character column only 
\end_layout

\begin_layout Itemize
informat 
\end_layout

\begin_layout Itemize
 format  
\end_layout

\begin_layout Itemize
label.
 
\end_layout

\begin_layout Standard
You 
\emph on
cannot
\emph default
 use the MODIFY clause to
\end_layout

\begin_layout Itemize
Change a character column to numeric or vice versa.
 To change a column's datatype, drop the column and then add it (and its
 data) again, or use the DATA step.
 
\end_layout

\begin_layout Itemize

\series bold
Change a column's name.

\series default
 You cannot change this attribute by using the ALTER TABLE statement; instead,
 you can use the SAS data set option RENAME= or the DATASETS procedure with
 the RENAME statement.
 
\end_layout

\begin_layout Subsection
Empty Table
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create table work.discount
\end_layout

\begin_layout Plain Layout

	(Destination char(4), * the first column specification indicates a column
 width of 3 for the character column Destination:
\end_layout

\begin_layout Plain Layout

	BeginDate num format=date9.,
\end_layout

\begin_layout Plain Layout

	EndDate  num format=date9.
 Label='End',
\end_layout

\begin_layout Plain Layout

	Discount num);
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Data type: is specified as CHAR or NUM 
\end_layout

\begin_layout Itemize
Column Width: Because the last three columns are numeric, no width is specified
 and these columns will have the default column width of 8 bytes, which
 allows for 16- or 17-digit precision within 8 bytes.
 
\end_layout

\begin_layout Itemize
Format: 
\end_layout

\begin_layout Standard

\series bold
Empty Table That Is Like Another Table
\end_layout

\begin_layout Standard
Suppose you want to create a new table, 
\emph on
Work.Flightdelays2
\emph default
, that contains data about flight delays.
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create table work.flightdelays2
\end_layout

\begin_layout Plain Layout

(drop = delaycategory destinationtype)
\end_layout

\begin_layout Plain Layout

like sasuser.flightdelays;
\end_layout

\end_inset


\end_layout

\begin_layout Standard

\series bold
The drop option can drop unwanted columns
\end_layout

\begin_layout Subsection
Table from a Query 
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

creat table work.ticketagents as
\end_layout

\begin_layout Plain Layout

	select lastname, firstname,
\end_layout

\begin_layout Plain Layout

	jobcode, salary
\end_layout

\begin_layout Plain Layout

from sasuser.payrollmaster,
\end_layout

\begin_layout Plain Layout

	sasuser.staffmaster
\end_layout

\begin_layout Plain Layout

where payrollmaster.empid = staffmaster.empid and jobcode contains 'TA';
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Copy table
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

create table work.supervisors2 as
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from sasuser.supervisors;
\end_layout

\begin_layout Plain Layout

(Drop)
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Drop Tables
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

drop table work.payrollmaster4;
\end_layout

\end_inset


\end_layout

\begin_layout Part
MySQL
\end_layout

\begin_layout Standard
dataset:
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

+----+------------+-----------+--------+---------------+ 
\end_layout

\begin_layout Plain Layout

| id | first_name | last_name | salary | department_id | 
\end_layout

\begin_layout Plain Layout

+----+------------+-----------+--------+---------------+ 
\end_layout

\begin_layout Plain Layout

|  1 | John       | Smith     |  20000 |             1 | 
\end_layout

\begin_layout Plain Layout

|  2 | Ava        | Muffinson |  10000 |             5 | 
\end_layout

\begin_layout Plain Layout

|  3 | Cailin     | Ninson    |  30000 |             2 | 
\end_layout

\begin_layout Plain Layout

|  4 | Mike       | Peterson  |  20000 |             2 | 
\end_layout

\begin_layout Plain Layout

|  5 | Ian        | Peterson  |  80000 |             2 | 
\end_layout

\begin_layout Plain Layout

|  6 | John       | Mills     |  50000 |             3 | 
\end_layout

\begin_layout Plain Layout

+----+------------+-----------+--------+---------------+ 
\end_layout

\end_inset


\end_layout

\begin_layout Itemize
Duplicated varaibles will all show up, not the first coversthe later ones
\end_layout

\begin_layout Itemize
cannot simply write *, has to write table.*
\end_layout

\begin_layout Itemize
SUM without group by will only return the first row
\end_layout

\begin_layout Itemize
\begin_inset listings
inline false
status open

\begin_layout Itemize

SELECT sum(1), first_name 
\end_layout

\begin_layout Itemize

FROM employees AS e 
\end_layout

\begin_layout Itemize

\end_layout

\begin_layout Itemize

-------------- 
\end_layout

\begin_layout Itemize

+--------+------------+ 
\end_layout

\begin_layout Itemize

| sum(1) | first_name | 
\end_layout

\begin_layout Itemize

+--------+------------+ 
\end_layout

\begin_layout Itemize

| 6 | John | 
\end_layout

\begin_layout Itemize

+--------+------------+ 
\end_layout

\begin_layout Itemize

1 row in set (0.08 sec) 
\end_layout

\begin_layout Itemize

\end_layout

\end_inset


\end_layout

\begin_layout Section
Calculated Variable
\end_layout

\begin_layout Standard
testing enviorment: https://coderpad.io/WGJCHDPJ
\end_layout

\begin_layout Standard
Only used when no GROUP BY
\end_layout

\begin_layout Itemize
Method 1: (select cal_var) as 
\end_layout

\begin_deeper
\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

SELECT 
\end_layout

\begin_layout Plain Layout

  e.id as new,
\end_layout

\begin_layout Plain Layout

  (select new) + 1 as anohter # works when no group by
\end_layout

\begin_layout Plain Layout

FROM employees   AS e
\end_layout

\begin_layout Plain Layout

JOIN departments AS d ON e.department_id = d.id
\end_layout

\begin_layout Plain Layout

having ( new ) >3;
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Itemize
Method 2: @cal_var:= existing, then use @cal_var later
\end_layout

\begin_deeper
\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

SELECT 
\end_layout

\begin_layout Plain Layout

  @test:=e.id as new,
\end_layout

\begin_layout Plain Layout

  @test + 1 as anohter, # works when no group by
\end_layout

\begin_layout Plain Layout

  d.name as department_name
\end_layout

\begin_layout Plain Layout

FROM employees   AS e
\end_layout

\begin_layout Plain Layout

JOIN departments AS d ON e.department_id = d.id
\end_layout

\begin_layout Plain Layout

having ( new ) >3;
\end_layout

\end_inset


\end_layout

\end_deeper
\begin_layout Standard
Test: calculated variables in GROUP BY cannot work
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

\end_layout

\begin_layout Plain Layout

select 
\end_layout

\begin_layout Plain Layout

  project_id,
\end_layout

\begin_layout Plain Layout

  sum(1) as real_sum, 
\end_layout

\begin_layout Plain Layout

  # cannot use real_sum here
\end_layout

\begin_layout Plain Layout

  
\end_layout

\begin_layout Plain Layout

  @test:=sum(1) as new,
\end_layout

\begin_layout Plain Layout

  # (select new) new1
\end_layout

\begin_layout Plain Layout

  @test + 5 as new1 # weired behavior
\end_layout

\begin_layout Plain Layout

from employees_projects
\end_layout

\begin_layout Plain Layout

  group by project_id
\end_layout

\begin_layout Plain Layout

  
\end_layout

\end_inset


\end_layout

\begin_layout Part
Proc SAS
\end_layout

\begin_layout Subsection
OUTBOS=10: head in R: Display data (limited rows showed)
\end_layout

\begin_layout Standard
Only show the first 10 observations in columns: flightnumber, date
\end_layout

\begin_layout Standard
proc sql 
\series bold
outobs=10
\series default
;
\end_layout

\begin_layout Standard
select flightnumber, date
\end_layout

\begin_layout Standard
from sasuser.flightschedule;
\end_layout

\begin_layout Subsection
INBOS=10: Only read first 10 columns, thus faster than OUTBOS
\end_layout

\begin_layout Subsection
roc sas: FEEDBACK option: Displaying All Column Names
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql feedback;
\end_layout

\begin_layout Plain Layout

select *
\end_layout

\begin_layout Plain Layout

from sasuser.staffchanges;
\end_layout

\end_inset


\end_layout

\begin_layout Subsection
Describe the Table
\end_layout

\begin_layout Standard
\begin_inset listings
inline false
status open

\begin_layout Plain Layout

proc sql;
\end_layout

\begin_layout Plain Layout

describe table work.discount;
\end_layout

\end_inset


\end_layout

\end_body
\end_document
