create database Wish
go
use Wish
go
--Users�������洢��̳ע���Ա����Ϣ
if exists(select 1 from sys.objects where name='Users'and type='U')
   drop table Users
go
create table Users
(
	UserId int identity primary key,--�û����
	UserName varchar(16) not null unique,--�û���
	Nickname varchar(16),
	Password varchar(60) not null,
	Email varchar(255),
	Question varchar(40) not null,
	Answer varchar(40) not null,
	Sex varchar(1) default 'M',
	ShowEmail bit not null default (1),
	Signature varchar(300) null,
	ImageUrl varchar(100) null default (''),
	AddedDate datetime not null default (getdate())
)on [primary]
go
insert into Users values
(
'sunchenhao','�ﳿ�','7C-22-2F-B2-92-7D-82-8A-F2-2F-59-21-34-E8-93-24-80-63-7C-0D',
'12312@qq.com','123456','123456','M',1,'����δ��д����ǩ��','images/faces/89.bmp',getdate()
)
insert into Users values
(
'zhaiyi','����','7C-22-2F-B2-92-7D-82-8A-F2-2F-59-21-34-E8-93-24-80-63-7C-0D',
'12312@qq.com','123456','123456','F',1,'����δ��д����ǩ��','images/faces/77.bmp',getdate()
)
insert into Users values
(
'youchangle','�ȳ���','7C-22-2F-B2-92-7D-82-8A-F2-2F-59-21-34-E8-93-24-80-63-7C-0D',
'12312@qq.com','123456','123456','F',1,'����δ��д����ǩ��','images/faces/48.bmp',getdate()
)
insert into Users values
(
'qiaobo','�ǲ�','7C-22-2F-B2-92-7D-82-8A-F2-2F-59-21-34-E8-93-24-80-63-7C-0D',
'12312@qq.com','123456','123456','M',1,'����δ��д����ǩ��','images/faces/67.bmp',getdate()
)
insert into Users values
(
'admin','admin','7C-22-2F-B2-92-7D-82-8A-F2-2F-59-21-34-E8-93-24-80-63-7C-0D',
'admin@qq.com','admin','admin','F',1,'����δ��д����ǩ��','images/faces/113.bmp',getdate()
)
select * from Users
--82132773
go

--Categories �������洢��̳���������ֺ�ͼ��
if exists(select 1 from sys.objects where name='Categories'and type='U')
   drop table dbo.[Categories]
go
create table Categories
(
	CategoryID int identity(1,1) not null primary key,
	CategoryName varchar(100) not null,
	CategoryImageUrl varchar(100) null,
	CategoryPosition int null
)on [primary] 
go
insert into Categories values('��Ѷ�������Ľ�����','images/Forums/Forums_wish.bmp',1)
insert into Categories values('����԰��','images/Forums/Forums_Development.gif',2)
insert into Categories values('�ճ��������','images/Forums/Forums_Manager.gif',3)
select * from Categories

go

--Forums ��洢�й��ض���̳����Ϣ���Լ������븸�����Ĺ�ϵ
if exists(select 1 from sys.objects where name='Forums'and type='U')
   drop table dbo.[Forums]
go
create table Forums
(
	ForumID int identity(1,1) not null primary key,
	CategoryID int not null references Categories(CategoryID)
	on delete cascade on update cascade,
	ForumName varchar(100) not null,
	ForumDescription varchar(250) null,
	ForumPosition int null	
)on [primary]
go
insert into Forums values(1,'�������','ѧԱ�������۹�ˮ��',1)
insert into Forums values(1,'�¿�վ����','ѧԱ�������۹�ˮ��',2)
insert into Forums values(1,'�ֶ�����','ѧԱ�������۹�ˮ��',3)
insert into Forums values(2,'.NET��̳','C#��ASP.NET��VB.NET��Web Services ',1)
insert into Forums values(2,'JAVA��̳','J2ME��J2SE��J2EE��EJB��Structs��Spring',2)
insert into Forums values(2,'Web����','ASP��Ajax��JSP��PHP��Javascript��CSS',3)
insert into Forums values(2,'���ݿ�����̳','Oracle��SQL Server��XML��MySQL��PB��ACCESS',4)
insert into Forums values(3,'��̳����','�����빫�桢���Ӳ�ѯ���ظ���ѯ������ͽ���',1)
select * from Forums

go
--Topics ��洢���й��ض���̳���������⣬�Լ������븸�����Ĺ�ϵ
if exists(select 1 from sys.objects where name='Topics'and type='U')
   drop table dbo.[Topics]
go
create table Topics
(
	TopicID int identity(1,1) not null primary key,
	ForumID int not null references Forums(ForumID)
	on delete cascade on update cascade,
	Subject varchar(100) not null,
	[Message] text not null,
	UserID int not null references Users(UserID)
	on delete cascade on update cascade,
	UserIP varchar(15) not null,
	AddedDate datetime not null default (getdate())
) on [primary] textimage_on[primary]
go
insert into Topics values(1,'�ձ������','�ձ����ݵ���������9.0�������',1,'192.168.0.151',getdate())
insert into Topics values(1,'������������ĸ��','����������ĸ���������ֺš��������к�׼����Ϯ������',1,'192.168.0.55',getdate())
insert into Topics values(1,'������������ĸ��','����������ĸ���������ֺš��������к�׼����Ϯ������',1,'192.168.0.55',getdate())
insert into Topics values(1,'������������ĸ��','����������ĸ���������ֺš��������к�׼����Ϯ������',1,'192.168.0.55',getdate())
insert into Topics values(1,'Diablo3��������','��ѩ��˾����2011����Ѯ�Ƴ�Diablo3',2,'192.168.0.21',getdate())
insert into Topics values(1,'�����Ǵ�ɧ��','�����ǽ��ܹ������Ϲ���ʾͣ��',3,'192.168.0.58',getdate())

select * from Topics
go
--Replies ��洢�˴����������͵���Ϣ
if exists(select 1 from sys.objects where name='Replies'and type='U')
   drop table dbo.[Replies]
go
create table Replies
(
	ReplyID int identity(1,1) not null primary key,
	ForumID int not null references Forums(ForumID),
	TopicID int not null references Topics(TopicID)
	on delete cascade on update cascade,
	[Message] text not null,
	UserID int not null references Users(UserID),
	UserIP varchar(15) not null,
	AddedDate datetime not null default (getdate())
)on [primary]
go
create trigger TrDelUser
on Users
instead of delete
as
begin
	delete from Replies where replyID in (select replyID from deleted)
	delete from Users where userID in (select userID from deleted)
end

go
--������ͼ
if exists(select 1 from sys.objects where name='v_Forums'and type='V')
   drop view dbo.[v_Forums]
go
create view v_Forums
as
select fc.CategoryID ,CategoryName,CategoryImageUrl,CategoryPosition,ForumID,
ForumName,ForumDescription,ForumPosition,
	(select count(*) from Topics
	 where Topics.ForumID=ff.ForumID)as ForumTopics,
	(select count(*) from Topics
	 where Topics.ForumID=ff.ForumID)+
	(select count(*) from Replies
	 where Replies.ForumID=ff.ForumID)as ForumPosts,
	(select max(AddedDate)
	 from (select ForumID,AddedDate
		 from Topics 
		 union all 
		 select ForumID,AddedDate 
		 from Replies) as dates
	     where dates.ForumID=ff.ForumID) as ForumLastPostDate
from Categories fc inner join Forums ff
on fc.CategoryID =ff.CategoryID
go
--select * from v_Replies
----------------------------------------------------------------------------------------------
if exists(select 1 from sys.objects where name='v_Topics'and type='V')
   drop view dbo.[v_Topics]
go
create view v_Topics
as
select v_Forums.CategoryID,CategoryName,CategoryPosition,v_Forums.ForumID,
ForumName,ForumDescription,ForumPosition,ForumTopics,ForumPosts,
Topics.TopicID,Topics.Subject,Topics.Message,Topics.AddedDate,UserIP,
	(select count(*)
	 from Replies
	 where Replies.TopicID=Topics.TopicID)as TopicReplies,
	 (select max(AddedDate)
	 From Replies
	 where Replies.TopicID=Topics.TopicID)as TopicLastReplyDate,
	 (select max(AddedDate)
	 from (select TopicID,AddedDate 
		from Topics
		union all
		select TopicID,AddedDate
		from Replies)as dates
		where dates.TopicID=Topics.TopicID)as TopicLastPostDate,
Users.UserID,UserName,Nickname,Email,Question,Answer,Sex,ShowEmail,Signature,
ImageUrl,Users.AddedDate as UserAddedDate
from v_Forums inner join Topics on v_Forums.ForumID=Topics.ForumID
inner join Users on Topics.UserID=Users.UserID
go
----------------------------------------------------------------------------------------------

if exists(select 1 from sys.objects where name='v_Replies'and type='V')
   drop view dbo.[v_Replies]
go
create view v_Replies
as
select v_Forums.CategoryID,CategoryName,v_Forums.ForumID,ForumName,
	Topics.TopicID,Replies.ReplyID,Replies.Message,Replies.AddedDate,Replies.UserIP,
	Users.UserID,UserName,NickName,ShowEmail,Signature,ImageUrl,Email
from Topics inner join Replies on Topics.TopicID=Replies.TopicID
inner join v_Forums on Topics.ForumID=v_Forums.ForumID
inner join Users on Replies.UserID=Users.UserID

go
-----------
--�����洢����
--�û�����
--1.�����û�
if exists(select 1 from sys.objects where name='InsertUser'and type='P')
   drop procedure dbo.[InsertUser]
go
create Procedure insertUser
	@UserName varchar(16),
	@Nickname varchar(16),
	@Password varchar(60),
	@Email varchar(255),
	@Question varchar(40),
	@Answer varchar(40),
	@Sex varchar(1),
	@ImageUrl varchar(100),
	@UserId int output
as
insert into Users
( UserName, Nickname, Password, Email, Question,Answer ,Sex ,ImageUrl ,AddedDate)
values( @UserName,@Nickname , @Password,@Email ,@Question , @Answer,@Sex ,@ImageUrl ,getdate())
set @UserID=scope_identity()
go

--2.ɾ���û�
if exists(select 1 from sys.objects where name='DeleteUser'and type='P')
   drop procedure dbo.[DeleteUser]
go
create procedure DeleteUser
	@UserID int
as
	delete from Users where UserID=@UserID
go

--3.�����û�Email
if exists(select 1 from sys.objects where name='UpdateUserEmail'and type='P')
   drop procedure UpdateUserEmail
go
create procedure UpdateUserEmail
	@UserID int,
	@Email varchar(255)
as
	update Users
	set Email=@Email
	where UserID=@UserID
go

--4.��֤��¼
if exists(select 1 from sys.objects where name='ValidateLogin'and type='P')
   drop procedure dbo.[ValidateLogin]
go
create procedure ValidateLogin
	@UserName varchar(16),
	@CryptPassword varchar(60)
as
	select UserID from Users where UserName=@UserName and Password=@CryptPassword

go
--5.�������п����û���Ϣ
if exists(select 1 from sys.objects where name='GetUsers'and type='P')
   drop procedure dbo.[GetUsers]
go
create procedure GetUsers
as
select UserID,UserName,Nickname,Email,Question,Answer,Sex,ShowEmail,Signature,
ImageUrl,AddedDate
from Users

go
--6.�����û����õ��û�id
if exists(select 1 from sys.objects where name='GetUserIDByUserName'and type='P')
   drop procedure dbo.[GetUsers]
go
create procedure GetUserIDByUserName
	@UserName varchar(16)
as
select UserID
From Users
where UserName=@UserName

go
--7.�����û���Ϣ
if exists(select 1 from sys.objects where name='UpdateUser'and type='P')
   drop procedure dbo.[UpdateUser]
go
create procedure UpdateUser
	@Nickname varchar(16),
	@Sex varchar(1),
	@ImageUrl varchar(100),
	@ShowEmail bit,
	@Signature varchar(300),
	@UserId int
as
	update Users
	set Nickname=@Nickname,Sex=@Sex,ImageUrl=@ImageUrl,
		ShowEmail=@ShowEmail,Signature=@Signature
	where UserId=@UserId
go

--8�������û�ID�õ��û���Ϣ
if exists(select 1 from sys.objects where name='GetUserByID'and type='P')
   drop procedure dbo.[GetUserByID]
go
create procedure GetUserByID
	@UserID int
as
	select * from Users where UserId=@UserID
go

--��������
--1.�������п��ð���
if exists(select 1 from sys.objects where name='GetCategories'and type='P')
   drop procedure dbo.[GetCategories]
go
create procedure GetCategories
as
select * from Categories
order by CategoryPosition Asc,CategoryName Asc
go


--2.�õ�ָ�������İ�������
if exists(select 1 from sys.objects where name='GetCategoryDetails'and type='P')
   drop procedure dbo.[GetCategoryDetails]
go
create procedure GetCategoryDetails
	@CategoryID int
as
select * from Categories
where CategoryID=@CategoryID
go


--3.����һ���µİ������������ڣ��򷵻�-1�����򷵻��°���ID��
if exists(select 1 from sys.objects where name='InsertCategory'and type='P')
   drop procedure dbo.[InsertCategory]
go
create procedure InsertCategory
	@CategoryName varchar(100),
	@CategoryImageUrl varchar(100),
	@CategoryPosition int,
	@CategoryID int output
as
declare @CurrID int --���˰���Ƿ����
select @CurrID=CategoryID
from Categories
where CategoryName=@CategoryName --��������ڣ������
if @CurrID is null
	begin
		insert into Categories
		(CategoryName,CategoryImageUrl,CategoryPosition)
		values(@CategoryName,@CategoryImageUrl,@CategoryPosition)
		set @CategoryID=scope_identity()
	end 
else
	begin
	set @CategoryID=-1	
	end
go

--4.����ָ��������������Ϣ
if exists(select 1 from sys.objects where name='UpdateCategory'and type='P')
   drop procedure dbo.[UpdateCategory]
go
create procedure UpdateCategory
	@CategoryID int,
	@CategoryName varchar(100),
	@CategoryImageUrl varchar(100),
	@CategoryPosition int
as
	update Categories
	set CategoryName=@CategoryName,CategoryImageUrl=@CategoryImageUrl,
	CategoryPosition=@CategoryPosition
	where CategoryID=@categoryID
go

--5.ɾ��ָ���İ���
if exists(select 1 from sys.objects where name='DeleteCategory'and type='P')
   drop procedure dbo.[DeleteCategory]
go
create procedure DeleteCategory
	@CategoryID int
as
delete from Categories
where CategoryID=@CategoryID
go


--��̳����
--1.����ָ�����������п�����̳
if exists(select 1 from sys.objects where name='GetForums'and type='P')
   drop procedure dbo.[GetForums]
go
create procedure GetForums
	@CategoryID int
as
select ForumID,ForumName,ForumDescription,ForumPosition,ForumTopics,ForumPosts,
ForumLastPostDate,CategoryID
from v_Forums
where categoryID=@categoryID
order by ForumPosition Asc, ForumName Asc
go

--2.�õ�ָ����̳����̳����
if exists(select 1 from sys.objects where name='GetForumsDetails'and type='P')
   drop procedure dbo.[GetForumsDetails]
go
create procedure GetForumsDetails
	@ForumID int
as
select * from v_Forums
where ForumID=@ForumID
go


--3.����һ���µ���̳�������ڣ�����-1�����򷵻�����̳��ID��
if exists(select 1 from sys.objects where name='InsertForum'and type='P')
   drop procedure dbo.[InsertForum]
go
create procedure InsertForum
	@CategoryID int,
	@ForumName varchar(100),
	@ForumDescription varchar(250),
	@ForumPosition int,
	@ForumID int output
as
declare @CurrID int --������̳�Ƿ����
select @CurrID=ForumID
from Forums
where ForumName=@ForumName and CategoryID=@CategoryID --��������ڣ������
if @CurrID is null
	begin
		insert into Forums
		(CategoryID,ForumName,ForumDescription,ForumPosition)
		values(@CategoryID,@ForumName,@ForumDescription,@ForumPosition)
		set @ForumID=scope_identity()
	end
else
	begin
		set @ForumID=-1
	end
go


--4.����ָ����̳��������Ϣ
if exists(select 1 from sys.objects where name='UpdateForum'and type='P')
   drop procedure dbo.[UpdateForum]
go
create procedure UpdateForum
	@ForumID int ,
	@ForumName varchar(100),
	@ForumDescription varchar(250),
	@ForumPosition int,
	@CategoryID int
as
update Forums
set ForumName=@ForumName,ForumDescription=@ForumDescription,
ForumPosition=@ForumPosition,CategoryID=@CategoryID
where ForumID=@ForumID
go

--5.ɾ��ָ������̳
if exists(select 1 from sys.objects where name='DeleteForum'and type='P')
   drop procedure dbo.[DeleteForum]
go
create procedure DeleteForum
	@ForumID int
as
delete from Forums
where ForumID=@ForumID
go

--6.���������õ�����
if exists(select 1 from sys.objects where name='GetTopicsByCondition'and type='P')
   drop procedure dbo.[GetTopicsByCondition]
go
create procedure GetTopicsByCondition
	@ForumID Varchar(2),
	@TimeType varchar(1),
	@StartTime varchar(20),
	@EndTime varchar(20),
	@TopicKey varchar(8000),
	@UserName varchar(16)
as
if @StartTime=''or @StartTime is null
	set @StartTime=dateadd(yy,-1,getdate()) 
if @EndTime=''or @EndTime is null
	set @EndTime=getdate()
if @TimeType=''or @TimeType is null
	set @TimeType='1'
if @TopicKey is null
	set @TopicKey=''
	
declare @sql nvarchar(4000)
set @sql='select CategoryName,ForumName,UserName,NickName,Email,ShowEmail,
TopicID,Subject,TopicReplies,AddedDate,TopicLastPostDate from v_Topics where 1=1'

if @ForumID>0
	set @sql=@sql+'and ForumID='+@ForumID
if @TimeType='1'
	set @sql=@sql+'and AddedDate>'''+@StartTime+'''and AddedDate<'''+
@EndTime+''''
if @EndTime='1'
	set @sql=@sql+'and TopicLastReplyDate>'''+@StartTime+'''and TopicLastReplyDate<'''+
@EndTime+''''
if @TopicKey <>''
	set @sql=@sql+'and subject like ''%'+@TopicKey+'%'''
if @UserName <>'' and @UserName is not null
	set @sql=@sql+'and UserName='''+@UserName+''''
set @sql=@sql+'order by TopicLastPostDate Desc'
exec sp_executesql @sql
go


--�������
--1.�õ�����
if exists(select 1 from sys.objects where name='GetTopics' and type='P')
   drop procedure GetTopics
go
create procedure GetTopics
	@ForumID int
as
select * from v_Topics where ForumID=@ForumID
go


--2.ɾ������
if exists(select 1 from sys.objects where name='DeleteTopics' and type='P')
   drop procedure DeleteTopics
go
create procedure DeleteTopics
	@TopicID int
as
delete from Topics where TopicID=@TopicID
go


--1.��������
if exists(select 1 from sys.objects where name='UpdatePassword'and type='P')
   drop procedure dbo.[UpdatePassword]
go
create procedure UpdatePassword
	@Password varchar(60),
	@UserId varchar(16)
as
update Users set Password=@Password where UserId=@UserId
go
--exec UpdatePassword '12345678',3
go


--2.��֤��ʾ����
if exists(select 1 from sys.objects where name='ValidateQuestion'and type='P')
   drop procedure dbo.[ValidateQuestion]
go
create procedure ValidateQuestion
	@UserName varchar(16),
	@Question varchar(40),
	@Answer varchar(40)
as
select UserId from Users
where UserName=@UserName and Question=@Question and Answer=@Answer
go

if exists(select 1 from sys.objects where name='DeleteReply'and type='P')
   drop procedure dbo.[DeleteReply]
go
create procedure DeleteReply
	@ReplyID int
as
delete from Replies where ReplyID=@ReplyID

go

if exists(select 1 from sys.objects where name='GetTopicDetails'and type='P')
   drop procedure dbo.[GetTopicDetails]
go
create procedure GetTopicDetails
	@TopicID int
as
select * from v_Topics where TopicID=@TopicID

go

--GetUsersIDByUserName�����û����õ���ID
if exists (select 1 from sys.all_objects where name = 'GetUsersIDByUserName' and type = 'P')
	drop procedure GetUsersIDByUserName
go
create procedure GetUsersIDByUserName
	 @username varchar(16)
as
	select userID from Users where userName = @username
go

--����ظ�InsertReply
if exists (select 1 from sys.all_objects where name = 'InsertReply' and type = 'P')
	drop procedure InsertReply
go
create procedure InsertReply
	 @forumID int 
	,@topicID int 
	,@message text 
	,@userID int 
	,@userIP varchar
	,@replyID int output
as
	insert into Replies (	forumID ,topicID ,[message] ,userID ,userIP)
	values (@forumID ,@topicID ,@message ,@userID ,@userIP)
	set @replyID = scope_identity()

go

--�õ��ظ�GetReplies
if exists (select 1 from sys.all_objects where name = 'GetReplies' and type = 'P')
	drop procedure GetReplies
go
create procedure GetReplies
	 @topicID int
as
	select * from V_Replies where TopicID=@topicID order by ReplyID
go

--���������õ��ظ�GetRepliesDetails
if exists (select 1 from sys.all_objects where name = 'GetRepliesDetails' and type = 'P')
	drop procedure GetRepliesDetails
go
create procedure GetRepliesDetails
	 @ReplyID int
as
	select * from V_Replies where ReplyID=@ReplyID
go

--����InsertTopic
if exists (select 1 from sys.all_objects where name = 'InsertTopic' and type = 'P')
	drop procedure InsertTopic
go
create procedure InsertTopic
	 @ForumID int,
	 @Subject varchar(100),
	 @Message text,
	 @UserID int,
	 @UserIP varchar(15),
	 @TopicID int output
as
	insert into Topics(ForumID,Subject,Message,UserID,UserIP)
	values (@ForumID,@Subject,@Message,@UserID,@UserIP)
	set @TopicID = scope_identity()
go



declare @aa int
exec InsertReply 1,1,'���Թŵ����Ǵ󷽿���',3,'12342543546',@aa output
exec InsertReply 1,1,'��˵���Ǻ˷��滮',3,'12342543546',@aa output
exec InsertReply 1,1,'��о��淶��',3,'12342543546',@aa output
exec InsertReply 1,2,'b��vf�󷨹�',2,'12342543546',@aa output
exec InsertReply 1,2,'�Ů��� �ط�',4,'12342543546',@aa output
exec InsertReply 1,3,'�ŵ���ʿ�����޷Ŵ�',1,'12342543546',@aa output
exec InsertReply 1,1,'ͬ������������',2,'12342543546',@aa output
exec InsertReply 1,1,'�淶���Է���˾',3,'12342543546',@aa output
exec InsertReply 1,1,'���Թŵ����Ǵ󷽿���',4,'12342543546',@aa output
exec InsertReply 1,1,'��˵���Ǻ˷��滮',5,'12342543546',@aa output
exec InsertReply 1,1,'��о��淶��',2,'12342543546',@aa output
exec InsertReply 1,2,'b��vf�󷨹�',2,'12342543546',@aa output
exec InsertReply 1,2,'�Ů��� �ط�',4,'12342543546',@aa output
exec InsertReply 1,3,'�ŵ���ʿ�����޷Ŵ�',4,'12342543546',@aa output
exec InsertReply 1,1,'ͬ������������',3,'12342543546',@aa output
exec InsertReply 1,1,'�淶���Է���˾',3,'12342543546',@aa output