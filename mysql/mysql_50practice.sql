/*********************
 * SQL经典50题,练习
 * 引自https://blog.csdn.net/flycat296/article/details/63681089
 *********************/

######目前存在疑问题目:9 13 
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
-- # 4. 查询所有同学的学生编号、学生姓名、选课总数、所有课程的总成绩(没成绩的显示为 null)
-- select B.Sid,B.Sname,A.CountOfCourse,A.SumOfScore from (select Sid,count(*) as CountOfCourse,sum(score) as SumOfScore from SC group by Sid)A 
-- right join student B on A.sid =B.sid order by SumOfScore desc;
-- # 4.1 查有成绩的学生信息
-- select B.Sid,B.Sname,A.CountOfCourse,A.SumOfScore from 
-- (select Sid,count(*) as CountOfCourse,sum(score) as SumOfScore from SC group by Sid having CountOfCourse is not null)A 
-- left join student B on A.sid =B.sid ; #由于不存在有成绩没人的情况，having语句可以省略
-- # 5. 查询「李」姓老师的数量 
-- select * from teacher where Tname like '李%';
-- # 6. 查询学过「张三」老师授课的同学的信息
-- # 注：实际中可能存在张三不止一个的情况如何处理,个人认为这种情况题目改为用id号检索更好（id一般是唯一的）
-- select * from student where Sid in (select distinct Sid from SC where Cid in (select distinct Cid from course where 
-- Tid=(select Tid from teacher where Tname="张三"))); 
-- # 7.查询没有学全所有课程的同学的信息
-- select * from student  where Sid in (select Sid from SC group by Sid having count(*)<3);

-- # 8. 查询至少有一门课与学号为" 01 "的同学所学相同的同学的信息 
-- select * from student where sid in (select distinct Sid from SC where Cid in (select Cid from SC where Sid='01') and Sid <>'01');

-- # 9. 查询和" 01 "号的同学学习的课程完全相同的其他同学的信息 

-- #(1),该方法为博客中所示方法，目前个人认为该方法不严谨在这个题目情况下加上count(cid)>=3判定一定能得出正确的结果
-- select * from Student 
-- where Sid in(select Sid from SC where Cid in (select distinct Cid from SC where Sid='01') and Sid<>'01'
-- group by Sid having count(cid)>=3);

-- #(2)该结果来自博客下'李哲男'评论
-- select * from student
-- where Sid in 
-- (select Sid from SC 
-- where Sid not in (select Sid from SC where  Cid not in (select Cid from SC where Sid='01'))
-- group by SC.Sid
-- having count(Cid)=(select count(Cid) from SC where Sid='01')) and Sid<>'01';

-- #(3)思路来自，博客https://blog.csdn.net/qq_41080850/article/details/84648897下'xianyu_x'给出的评论，答案应该是对的但是查找次数较多运算效率无法保证
-- select * from student where sid in (select sid from 
-- (select SC.Sid,GROUP_CONCAT(SC.cid order by SC.Cid) as 'all_course' from SC 
-- group by SC.sid)all_s where all_s.all_course=(select GROUP_CONCAT(A_01.cid order by A_01.Cid) as 'all_course' 
-- from (select distinct Sid,Cid from SC where sid='01')A_01 group by A_01.sid ) and Sid<>'01');

-- # 10.查询没学过"张三"老师讲授的任一门课程的学生姓名
-- select Sname from student where Sid not in 
-- (select distinct Sid from SC where cid in
--  (select distinct Cid from course where Tid=
--  (select Tid from teacher where Tname=N'张三')));

-- # 11. 查询两门及其以上不及格课程的同学的学号，姓名及其平均成绩
-- select  student.Sid,student.Sname,avgOfScore from
--  student right join
--  (select Sid,avg(score) as avgOfScore from sc where score< 60 group by Sid having count(*)>=2)A on student.sid=A.sid ; 
 
-- # 12. 检索" 01 "课程分数小于 60，按分数降序排列的学生信息
-- select student.*,Score from 
-- student  right join (select Sid, Score from SC where Cid='01' and score<60)s on s.sid=student.sid 
-- order by s.score desc;

-- # 13. 按平均成绩从高到低显示所有学生的所有课程的成绩以及平均成绩(将原答案中O改为NULL，根据生活尝试无成绩与成绩为零应为两种不同的方式)
-- #该题目应该有更简单的处理方法可以进行考虑
-- select Sid,max(case Cid when '01' then score else NULL end)'01',
-- max(case Cid when '02' then score else NULL end)'02',
-- max(case Cid when '03' then score else NULL end)'03',AVG(score)平均分 from SC
-- group by Sid order by 平均分 desc;

# 14.查询各科成绩最高分、最低分和平均分：
	#以如下形式显示：课程 ID，课程 name，最高分，最低分，平均分，及格率，中等率，优良率，优秀率
    #及格为>=60，中等为：70-80，优良为：80-90，优秀为：>=90
    #要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列

-- select Cid,max(score)'maxOfScore',min(score)'minOfScore',avg(score)'avgOfScore',
-- round(sum(case when score>=60 then 1.0 else 0 end)/count(*)*100.0,2) as '及格率',
-- round(sum(case when score>=70 and score<80 then 1.0 else 0.0 end)/count(*)*100.0,2) as '中等率',
-- round(sum(case when score>=80 and score<90 then 1.0 else 0.0 end)/count(*)*100.0,2) as '优良率',
-- round(sum(case when score>=90 then 1.0 else 0.0 end)/count(*) /count(*),2)*100.0 as '优秀率'
--  from SC group by Cid order by Cid;

-- #  15. 按各科成绩进行排序，并显示排名， Score 重复时保留名次空缺,窗口函数
-- select *,RANK()over(partition by Cid order by score desc)'排名' from SC ;
-- # 15.1 按各科成绩进行排序，并显示排名， Score 重复时合并名次
-- select *,dense_rank()over(partition by Cid order by score desc)'排名' from SC ;
-- #(1)按各科成绩进行排序，并显示排名，赋予唯一的连续位次
-- select *,row_number()over(partition by Cid order by score desc)'排名' from SC ;

-- # 16.  查询学生的总成绩，并进行排名，总分重复时保留名次空缺
-- select B.Sid,B.Sname,A.总分,A.排名  from student as B right join
-- (select  Sid,sum(score)总分,rank()over(order by sum(score)desc )排名 from SC group by Sid)A  on B.Sid=A.Sid; 

-- #16.1 查询学生的总成绩，并进行排名，总分重复时不保留名次空缺
-- select B.Sid,B.Sname,A.总分,A.排名  from student as B right join
-- (select  Sid,sum(score)总分,dense_rank()over(order by sum(score)desc )排名 from SC group by Sid)A  on B.Sid=A.Sid; 

-- # 17. 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比
