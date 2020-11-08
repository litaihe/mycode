/*********************
 * SQL经典50题,练习
 * 引自https://blog.csdn.net/flycat296/article/details/63681089
 *********************/

######目前存在疑问题目:9 13 18 23
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

# 17. 统计各科成绩各分数段人数：课程编号，课程名称，[100-85]，[85-70]，[70-60]，[60-0] 及所占百分比
# (1)
-- select  distinct course.cname, A.* from course right join(select cid,
-- sum(case when score<=100 and score>=85 then 1 else 0 end)"[100-85]",
-- round(sum(case when score<=100 and score>=85 then 1 else 0 end)/count(*)*100,2) as "per:[100-85]",
-- sum(case when score<85 and score>=70 then 1 else 0 end)"[80-75]",
-- round(sum(case when score<85 and score>=70 then 1 else 0 end)/count(*)*100,2) as "per:[80-75]",
-- sum(case when score<70 and score>=60 then 1 else 0 end)"[70-60]",
-- round(sum(case when score<70 and score>=60 then 1 else 0 end)/count(*)*100,2) as "per:[70-60]",
-- sum(case when score<60 and score>=0  then 1 else 0 end)"[60-0]",
-- round(sum(case when score<60 and score>=0  then 1 else 0 end)/count(*)*100,2) as "per:[60-0]"
--  from SC group by cid )A on course.cid=A.cid order by A.cid ;
#(2)

-- # 18. 查询各科成绩前三名的记录
-- #(1)
-- select S.sid,S.Sname,B.score,B.RankOfScore from student S right join 
-- (select * from  (select *,rank()over(partition by Cid order by score desc) as RankOfScore from SC)A where A.RankOfScore<=3)B 
-- On B.sid=S.sid ;
-- #(2)
-- select a.Sid,a.Cid,a.score from SC a 
-- left join SC b on a.Cid=b.Cid and a.score<b.score
-- group by a.Sid,a.Cid,a.score
-- having COUNT(b.Sid)<3
-- order by a.Cid,a.score desc

-- # 19. 查询每门课程被选修的学生数
-- select C.*,CountOfCourse from course C right  join 
-- (select Cid,count(*) as CountOfCourse from SC group by Cid)S on C.Cid=S.Cid order by Cid; 

-- # 20. 查询出只选修两门课程的学生学号和姓名
-- select Sid,Sname from student where Sid in (select Sid from SC group by Sid having count(Cid)=2);

-- # 21. 查询男生、女生人数
-- select Ssex 性别,count(Sid) 人数  from student group by Ssex ;

-- # 22. 查询名字中含有「风」字的学生信息
-- select * from student where Sname like "%风%";

-- # 23. 查询同名同性学生名单，并统计同名人数(不知如何处理)
-- select Sname,Ssex,count(*) from student group by Sname,Ssex having count(*)>=2;

-- #24. 查询 1990 年出生的学生名单
-- select * from student where year(Sage)=1990;

-- # 25. 查询每门课程的平均成绩，结果按平均成绩降序排列，平均成绩相同时，按课程编号升序排列
-- select Cid,avg(score) from SC group by Cid order by avg(score) desc,Cid;

-- # 26. 查询平均成绩大于等于 85 的所有学生的学号、姓名和平均成绩
-- select B.Sid,B.sname,avgOfScore from student B right join
-- (select  Sid,avg(score) as avgOfScore  from SC group by Sid having avg(score)>=85)A on A.sid=B.sid;

-- # 27. 查询课程名称为「数学」，且分数低于 60 的学生姓名和分数

--  select B.Sname,A.score from student B 
--  right join(select Sid,Score from SC where 
--  Cid in (select Cid from course where Cname=N'数学') and score<60)A 
--  on A.sid=B.sid;
 
 -- # 28. 查询所有学生的课程及分数情况（存在学生没成绩，没选课的情况）
 -- select A.Sid,A.sname,B.Cid,B.score from Student A left join SC B on A.Sid=B.Sid;
 
 -- # 29. 查询任何一门课程成绩在 70 分以上的姓名、课程名称和分数
--  select B.Sname,C.Cname,A.score from (select Sid,Cid,Score from SC where score>70)A 
--  left join student B on A.Sid =B.sid 
--  left join course C on A.Cid=C.cid order by B.sname;

-- # 30. 查询不及格的课程
-- select * from SC where score<60;


-- # 31. 查询课程编号为 01 且课程成绩在 80 分以上的学生的学号和姓名
-- # (1)
-- select A.sid,A.Sname from Student A where Sid in (select Sid from SC where Cid='01' and score<80);
-- # (2)
-- select A.Sid,B.Sname from (select * from SC where score<80 and Cid=01)A
-- left join Student B on A.Sid=B.Sid;

-- # 32. 求每门课程的学生人数
-- select B.Cname as 课程名称 ,A.学生人数  from (select Cid,count(*) as 学生人数 from SC group by Cid)A left join course B on A.cid=B.cid;


-- # 33. 成绩不重复，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩
-- #(1)
-- select S.Sid,S.Sname,A.MaxOfScore from student S right join(select Sid,Max(score) as MaxOfSCore from SC where Sid in
-- (select Sid from SC where Cid in 
-- (select Cid from course where Tid in(select Tid from teacher where Tname="张三"))))A on A.Sid=S.Sid ;
-- #(2)
-- select * from SC 
-- where Cid=(select Cid from Course where Tid=(select Tid from Teacher where Tname='张三')) 
-- order by score desc limit 1;

-- #34. 成绩有重复的情况下，查询选修「张三」老师所授课程的学生中，成绩最高的学生信息及其成绩
-- select * from (select *,dense_rank()over(order by Score desc)A from SC 
-- where Cid=(select Cid from Course where Tid=(select Tid from Teacher where Tname='张三')))B  where B.A=1;

-- #35. 查询不同课程成绩相同的学生的学生编号、课程编号、学生成绩 
-- select A.sid,A.Cid,score from  (select Sid ,group_concat(Cid)Cid ,score from SC group by Sid having min(score)=max(score))A;
-- #36. 查询每门功成绩最好的前两名
-- select * from (select *,row_number()over(partition by Cid order by Score desc )A from SC)B where B.A<3;

-- # 37. 统计每门课程的学生选修人数(超过 5 人的课程才统计)
-- #要求输出课程号和选修人数，查询结果按人数降序排列，若人数相同，按课程号升序排列
-- select Cid,Count(*)StudentNumber from SC group by Cid having count(*)>5 order by StudentNumber desc,Cid;

-- # 38. 检索至少选修两门课程的学生学号
-- select Sid from SC group by Sid having count(*)>=2;
 
-- # 39. 查询选修了全部课程的学生信息
-- select * from student where Sid in 
-- (select Sid from SC group by Sid having count(*)=(select distinct count(*) from course));


-- # 40. 查询各学生的年龄,只按年份来算

-- select Sid,year(now())-year(sage) as 年龄 from Student;

-- 41. 按照出生日期来算，当前月日 < 出生年月的月日则，年龄减一
-- select *,(year(now())-year(sage))age_old,
-- (case when month(now())<month(Sage) then year(now())-year(sage)-1 else year(now())-year(sage) end)age from student; 

-- # 42. 查询本周过生日的学生
delimiter //
start transaction;

    set @nowdate=curdate();
    -- select @nowdate;
    set @DayOfWeek=DayOfWeek(@nowdate);
    -- select @DayOfWeek;
    set @weekBg=date_add(@nowdate,interval -@DayOfWeek+1 day);
    -- select @weekBg ;
    set @weekEd=date_add(@nowdate,interval  @DayOfWeek-1 day);
    select @weekEd;

commit // 
delimiter ;

-- # 43. 查询下周过生日的学生

-- # 44. 查询本月过生日的学生
-- select * from student where month(now())=month(Sage); 

-- #45. 查询下月过生日的学生
-- select * from student where month(date_add(now(),interval 1 month))=month(Sage);