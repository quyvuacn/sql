CREATE DATABASE Lab_12 GO USE Lab_12 GO -- Tạo Bảng

CREATE TABLE Employee(EmployeeID int PRIMARY KEY,
                                             Name varchar(100),
                                                  Tel char(11),
                                                      Email varchar(30)) GO
CREATE TABLE Project (ProjectID int PRIMARY KEY,
                                            ProjectName varchar(30),
                                                        StartDate datetime,
                                                        EndDate datetime,
                                                        Period int , Cost MONEY) GO
CREATE TABLE Groups (GroupID int PRIMARY KEY,
                                         GroupName varchar(30),
                                                   LeaderID int
                     FOREIGN KEY REFERENCES Employee(EmployeeID),
                                            ProjectID int
                     FOREIGN KEY REFERENCES Project(ProjectID)) GO
CREATE TABLE GroupDetail (GroupID int
                          FOREIGN KEY REFERENCES Groups(GroupID),
                                                 EmployeeID int
                          FOREIGN KEY REFERENCES Employee(EmployeeID),
                                                 Status char(20)) GO -- YÊU CẦU
-- 2. Thêm dữ liệu cho các bảng

INSERT INTO Employee
VALUES(1,'Nguyen Van Sinh','098657431','email@gmail.com'),
      (2,'Đinh Hoang Long','077657431','email@gmail.com'),
      (3,'Pham Thi Men','033657431','email@gmail.com'),
      (4,'Luong Van An','078657431','email@gmail.com'),
      (5,'Phan Van Tinh','068657431','email@gmail.com') GO INSERT INTO Project VALUES(1,'Open City','2020/02/15','2021/09/18',18,2000),

                                                                                     (2,'Deco park','2020/01/28','2022/01/05',24,9000),
                                                                                     (3,'FLC Gof','2019/02/25','2021/02/20',32,7000) GO INSERT INTO Groups VALUES(1,'GTOP1',1,1),

                                                                                                                                                                 (2,'GTOP2',2,2),
                                                                                                                                                                 (3,'GTOP3',3,3) GO INSERT INTO GroupDetail VALUES(1,1,'Dang Lam'),

                                                                                                                                                                                                                  (2,2,'Dang Lam'),
                                                                                                                                                                                                                  (3,3,'Dang Lam'),
                                                                                                                                                                                                                  (2,4,'Dang Lam'),
                                                                                                                                                                                                                  (3,5,'Dang Lam') GO
SELECT *
FROM GroupDetail
SELECT *
FROM Groups -- 3. Viết câu lệnh truy vấn để:
-- a. Hiển thị thông tin của tất cả nhân viên

SELECT *
FROM Employee GO -- b. Liệt kê danh sách nhân viên đang làm dự án “Deco park”

SELECT *
FROM Employee
INNER JOIN GroupDetail ON Employee.EmployeeID = GroupDetail.EmployeeID
INNER JOIN Groups ON GroupDetail.GroupID = Groups.GroupID
INNER JOIN Project ON Project.ProjectID = Groups.ProjectID
WHERE Project.ProjectID = 2 GO -- c. Thống kê số lượng nhân viên đang làm việc tại mỗi nhóm

  SELECT Groups.GroupName,
         COUNT(*) [SLNV]
  FROM Groups
  JOIN GroupDetail ON Groups.GroupID = GroupDetail.GroupID
GROUP BY Groups.GroupName GO -- d. Liệt kê thông tin cá nhân của các trưởng nhóm

SELECT *
FROM Groups
JOIN Employee ON Groups.LeaderID = Employee.EmployeeID GO -- e. Liệt kê thông tin về nhóm và nhân viên đang làm các dự án có ngày bắt đầu làm trước ngày 12/10/2010

SELECT a.Name,
       b.GroupName,
       d.ProjectName
FROM Employee a
JOIN GroupDetail c ON a.EmployeeID = c.EmployeeID
JOIN Groups b ON c.GroupID = b.GroupID
JOIN Project d ON d.ProjectID = b.ProjectID
WHERE d.StartDate < '2020/01/20' GO -- f. Liệt kê tất cả nhân viên dự kiến sẽ được phân vào các nhóm làm việc

  SELECT a.Name,
         b.GroupName
  FROM Employee a
  JOIN GroupDetail c ON a.EmployeeID = c.EmployeeID
  JOIN Groups b ON c.GroupID = b.GroupID GO -- g. Liệt kê tất cả thông tin về nhân viên, nhóm làm việc, dự án của những dự án đã hoàn thành

  SELECT *
  FROM Employee a
  JOIN GroupDetail c ON a.EmployeeID = c.EmployeeID
  JOIN Groups b ON c.GroupID = b.GroupID
  JOIN Project d ON d.ProjectID = b.ProjectID WHERE d.EndDate <= '2022/01/13' GO --4 Viết câu lệnh kiểm tra:
-- a. Ngày hoàn thành dự án phải sau ngày bắt đầu dự án

  ALTER TABLE Project ADD CONSTRAINT dat_e CHECK (EndDate > StartDate) GO -- b. Trường tên nhân viên không được null

  ALTER TABLE Employee
  ALTER COLUMN Name varchar(100) NOT NULL GO -- c. Trường trạng thái làm việc chỉ nhận một trong 3 giá trị: inprogress, pending, done

  ALTER TABLE GroupDetail ADD CONSTRAINT sta_tus Check(Status In ('inprogress',
                                                                  'pending',
                                                                  'done')) GO -- d. Trường giá trị dự án phải lớn hơn 1000

  ALTER TABLE Project ADD CONSTRAINT Du_an Check(Cost > 1000) GO -- e. Trưởng nhóm làm việc phải là nhân viên

  ALTER TABLE Groups ADD CONSTRAINT t_k LeaderID int
  FOREIGN KEY REFERENCES Employee(EmployeeID) GO -- f. Trường điện thoại của nhân viên chỉ được nhập số và phải bắt đầu bằng số 0

  ALTER TABLE Employee ADD CONSTRAINT te_l CHECK (Tel Like '[0][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') GO --5 Tạo các thủ tục lưu trữ thực hiện:
-- a. Tăng giá thêm 10% của các dự án có tổng giá trị nhỏ hơn 2000

  CREATE Proc SP_persent AS
  UPDATE Project
  SET Cost = Cost * 0.1 WHERE Cost < 2000 GO -- b. Hiển thị thông tin về dự án sắp được thực hiện

  CREATE Proc SP_Project_Featrure AS
  SELECT *
  FROM Project WHERE StartDate > Getdate() GO -- c. Hiển thị tất cả các thông tin liên quan về các dự án đã hoàn thành

  CREATE Proc SP_Finist AS
  SELECT *
  FROM Project WHERE EndDate <= Getdate() GO -- 6 Tạo các chỉ mục:
-- a. Tạo chỉ mục duy nhất tên là IX_Group trên 2 trường GroupID và EmployeeID của bảng GroupDetail

  CREATE UNIQUE INDEX IX_Group ON GroupDetail(GroupID,
                                              EmployeeID) GO -- b. Tạo chỉ mục tên là IX_Project trên trường ProjectName của bảng Project gồm các trường StartDate và EndDate

  CREATE INDEX IX_Project ON Project(ProjectName,
                                     StartDate,
                                     EndDate) GO -- 7 Tạo các khung nhìn để
-- a. Liệt kê thông tin về nhân viên, nhóm làm việc có dự án đang thực hiện

  CREATE VIEW V_DangThuchien AS
  SELECT a.Name,
         a.tel,
         a.Email,
         b.GroupName
  FROM Employee a
  JOIN GroupDetail c ON a.EmployeeID = c.EmployeeID
  JOIN Groups b ON c.GroupID = b.GroupID
  JOIN Project d ON d.ProjectID = b.ProjectID WHERE d.EndDate < GetDate() GO -- b. Tạo khung nhìn chứa các dữ liệu sau: tên Nhân viên, tên Nhóm, tên Dự án và trạng thái làm việc của Nhân viên.

  CREATE VIEW V_TongHop AS
  SELECT a.Name,
         b.GroupName,
         d.ProjectName
  FROM Employee a
  JOIN GroupDetail c ON a.EmployeeID = c.EmployeeID
  JOIN Groups b ON c.GroupID = b.GroupID
  JOIN Project d ON d.ProjectID = b.ProjectID GO -- 8 Tạo Trigger thực hiện công việc sau:
-- a. Khi trường EndDate được cập nhật thì tự động tính toán tổng thời gian hoàn thành dự án và cập nhật vào trường Period

  CREATE TRIGGER Update_Period ON Project AFTER
  UPDATE AS BEGIN
  UPDATE Project
  SET Period = DATEDIFF(m, StartDate, EndDate) END GO -- Test

  UPDATE Project
  SET EndDate = '2022/10/14'
  SELECT *
  FROM Project GO -- b. Đảm bảo rằng khi xóa một Group thì tất cả những bản ghi có liên quan trong bảng GroupDetail cũng sẽ bị xóa theo.

  CREATE TRIGGER Delete_Group ON GroupDetail
  FOR
  DELETE AS BEGIN
  DELETE
  FROM GroupDetail
  WHERE GroupID In
      (SELECT *
       FROM deleted) END GO -- c. Không cho phép chèn 2 nhóm có cùng tên vào trong bảng Group.

  CREATE TRIGGER Test_Insert ON Groups
  FOR
  INSERT AS BEGIN IF EXISTS
    (SELECT *
     FROM Groups a
     JOIN inserted b ON a.GroupName = b.GroupName) BEGIN PRINT 'Ten Group khong duoc trung lap !'
  ROLLBACK TRANSACTION END END GO