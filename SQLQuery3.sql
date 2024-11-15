

Create database Task

Create table Books(
BookId int identity(1,1) primary key,
BookName nvarchar(50) check(len(BookName) between 2 and 100),
BookAuthorId int references Authors(AuthorId),
BookPageCount int Check(BookPageCount>10)
)


create table Authors(
AuthorId int identity(1,1) primary key,
AuthorName nvarchar(50),
AuthorSurname nvarchar(50)
)
insert into Books values
('Suc ve ceza',1,100),
('Sefiller',2,280),
('Erdogan operasyonu',3,140)


insert into Authors values
('Fyodor','Dostoyevski'),
('Viktor',N'Hüqo'),
('Ömer','Lütfi Mete')


select* from Books
select* from Authors
--1)
create view BookAuthor as
select BookId,BookName,BookPageCount,concat(AuthorName,' ',AuthorSurname ) as AuthorFullName from Books
Join Authors on Books.BookAuthorId=AuthorId

--2)
create procedure uspBookAuthor (@name nvarchar(50))
as
begin
select BookId,BookName,BookPageCount,concat(AuthorName,' ',AuthorSurname) as AuthorFullName from Books
join Authors on Books.BookAuthorId=AuthorId
where BookName like @name
end
exec uspBookAuthor @name='Sefiller'
--3)
--3.1
create procedure InsertData @name nvarchar(50),@surname nvarchar(50)
as
begin
insert into Authors values(@name,@surname)
end

--3.2
create procedure UpdateData @Id int,@name nvarchar(50),@surname nvarchar(50)
as
begin
update Authors set AuthorName=@name,AuthorSurname=@surname
where AuthorId=@Id
end

--3.3
create procedure DeleteData @Id int
as
begin
delete from Authors where AuthorId=@Id
end

--4)
create view Infos as
select AuthorId,Concat(AuthorName,' ',AuthorSurname)as AuthorFullName,max(BookPageCount) as MaxPageCount from Authors
left join Books on Authors.AuthorId=BookAuthorId
group by
Authors.AuthorId,Authors.AuthorName,Authors.AuthorSurname


