/*********************
 * SQL经典50题,练习
 * 引自https://blog.csdn.net/flycat296/article/details/63681089
 *********************/

-- #创建学生表
-- create table Student
-- (Sid varchar(10),
-- Sname nvarchar(10),
-- Sage datetime,
-- Ssex nvarchar(10));
-- insert into Student
-- (Sid,Sname,Sage,Ssex)
-- values
-- ('01' , N'赵雷' , '1990-01-01' , N'男'),
-- ('02' , N'钱电' , '1990-12-21' , N'男'),
-- ('03' , N'孙风' , '1990-05-20' , N'男'),
-- ('04' , N'李云' , '1990-08-06' , N'男'),
-- ('05' , N'周梅' , '1991-12-01' , N'女'),
-- ('06' , N'吴兰' , '1992-03-01' , N'女'),
-- ('07' , N'郑竹' , '1989-07-01' , N'女'),
-- ('08' , N'王菊' , '1990-01-20' , N'女');
-- select * from Student;

-- #创建课程表
-- create table Course(Cid varchar(10),Cname nvarchar(10),Tid varchar(10));
-- insert into Course values('01' , N'语文' , '02');
-- insert into Course values('02' , N'数学' , '01');
-- insert into Course values('03' , N'英语' , '03');
-- select * from Course;

-- #创建老师表
-- create table Teacher(Tid varchar(10),Tname nvarchar(10));
-- insert into Teacher values('01' , N'张三');
-- insert into Teacher values('02' , N'李四');
-- insert into Teacher values('03' , N'王五');
-- select * from Teacher;

-- #创建成绩表
-- create table SC(Sid varchar(10),Cid varchar(10),score decimal(18,1));
-- insert into SC values('01' , '01' , 80);
-- insert into SC values('01' , '02' , 90);
-- insert into SC values('01' , '03' , 99);
-- insert into SC values('02' , '01' , 70);
-- insert into SC values('02' , '02' , 60);
-- insert into SC values('02' , '03' , 80);
-- insert into SC values('03' , '01' , 80);
-- insert into SC values('03' , '02' , 80);
-- insert into SC values('03' , '03' , 80);
-- insert into SC values('04' , '01' , 50);
-- insert into SC values('04' , '02' , 30);
-- insert into SC values('04' , '03' , 20);
-- insert into SC values('05' , '01' , 76);
-- insert into SC values('05' , '02' , 87);
-- insert into SC values('06' , '01' , 31);
-- insert into SC values('06' , '03' , 34);
-- insert into SC values('07' , '02' , 89);
-- insert into SC values('07' , '03' , 98);
-- select * from teacher;

-- #1：查询" 01 "课程比" 02 "课程成绩高的学生的信息及课程分数
-- #可以实现要求的目的但是多次的连接是否会使效率很慢待考察
-- select D.*,score_coure1,score_coure2 from 
-- (select A.Sid as Sid,A.score as score_coure1,B.score as score_coure2 
-- from (select Sid,score from SC where Cid='01')A 
-- left join (select Sid,score from SC where Cid='02')B 
-- on A.Sid=B.Sid
-- where A.score>B.score)C 
-- inner join (Select Sid,Sname,Sage,Ssex from Student)D on C.Sid=D.sid ;

-- #1.1 查询同时存在" 01 "课程和" 02 "课程的情况
-- #(1)使用内连接
-- select A.Sid,A.score as score_coure1,B.Score as score_coure2
-- from (select Sid,score from SC where Cid='01')A 
-- inner join (select Sid,score from SC where Cid='02')B 
-- on A.Sid=B.Sid;
-- #(2)使用左连接+条件判断
-- select A.Sid,A.score as score_coure1,B.Score as score_coure2
-- from (select Sid,score from SC where Cid='01')A 
-- left join (select Sid,score from SC where Cid='02')B 
-- on A.Sid=B.Sid where  A.score is not null and B.score is not null;
-- # 1.2 查询存在" 01 "课程但可能不存在" 02 "课程的情况(不存在时显示为 null )
-- select A.Sid,A.score as score_coure1,B.Score as score_coure2
-- from (select Sid,score from SC where Cid='01')A 
-- left join (select Sid,score from SC where Cid='02')B 
-- on A.Sid=B.Sid;
-- # 1.3 查询不存在" 01 "课程但存在" 02 "课程的情况
-- #(1)左连接更换顺序
-- select A.Sid,A.score as score_coure1,B.Score as score_coure2
-- from (select Sid,score from SC where Cid='02')A 
-- left join (select Sid,score from SC where Cid='01')B 
-- on A.Sid=B.Sid;
-- #(2)右连接
-- select B.Sid,A.score as score_coure1,B.Score as score_coure2
-- from (select Sid,score from SC where Cid='01')A 
-- right join (select Sid,score from SC where Cid='02')B 
-- on A.Sid=B.Sid;

-- #2.查询平均成绩大于等于 60 分的同学的学生编号和学生姓名和平均成绩
-- select B.*,A.avgOfScore from (select Sid,avg(score) as avgOfScore from SC group by Sid)A 
-- inner join (select Sid,Sname from Student)B on A.Sid=B.Sid where avgOfScore>60;
-- #3.查询在表中存在成绩的学生信息
-- select * from student where Sid in (select distinct Sid from SC);
