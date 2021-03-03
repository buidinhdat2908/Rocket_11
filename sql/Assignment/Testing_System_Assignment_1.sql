DROP DATABASE IF EXISTS Assignment ;
CREATE DATABASE Assignment;
USE Assignment;

-- bang 1 --
CREATE TABLE Department(
DepartmentID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL ,
DepartmentName 		VARCHAR(30)	UNIQUE KEY NOT NULL
);
-- add data Department
INSERT INTO Department ( DepartmentName) 
VALUES				   ( 'Marketing' ),
					   ( 'sale' ),
                       ( 'bao ve' ),
                       ( 'nhan su' ),
                       ( 'ky thuat' ),
                       ( 'tai chinh' ),
                       ( 'pho giam doc' ),
                       ( 'giam doc' ),
                       ( 'thu ki' ),
                       ( 'ban hang' );
    

-- bang 2 --
CREATE TABLE Position (
PositionID  TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT NOT NULL,
PositionName VARCHAR(30) NOT NULL UNIQUE KEY
);
-- add date Position
INSERT INTO Position 	( PositionName )
VALUES					( 'DEV' ),
						( 'Test' ),
						( 'Scrum Master' ),
						( ' PM ' );
                            
-- bang 3--
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account` (
AccountID 		TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
Email     		VARCHAR(50) NOT NULL  NOT NULL UNIQUE KEY,
Username    	VARCHAR(30) NOT NULL  NOT NULL UNIQUE KEY,
FullName    	VARCHAR(30) NOT NULL ,
DepartmentID 	TINYINT UNSIGNED NOT NULL,
PositionID      TINYINT UNSIGNED NOT NULL,
CreateDate     	DATETIME DEFAULT NOW(),
FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
FOREIGN KEY(PositionID) REFERENCES Position (PositionID)
);
-- add data Account--
INSERT INTO `Account` ( Email                  		,       Username     	,     FullName      ,   DepartmentID   	    ,      PositionID   ,   CreateDate  )
VALUES                ('buidinhdat14@gmail.com'		,     	'taikhoan1'    	,   'buidinhdat'    ,    	' 1 '        	,     		'1'		,  '2021/2/3'	),
                      ('hoangvui99@gmail.com'   	,     	'taikhoan2'    	,   'hoangthivui'   ,    	' 2 '			,			'1'		,  '2019/4/3'	),
                      ('nguyencuong98@gmail.com'	,     	'taikhoan3'	 	,	'nguyencuong'	,		' 3 '			,	 		'2'		,  '2018/5/4'	),
                      ('mailoan90@gmail.com'		,	  	'taikhoan4'		,	'mailoan'		,		' 4 ' 			,			'3'		,  '2017/6/7' 	),
                      ('manhdung96@gmail.com'		, 		'taikhoan5'		, 	'manhdung'		,		' 5 '			,	 		'4' 	,  '2018/9/8'	);

-- bang 4 --
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group` (
GroupID 	TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT ,
GroupName 	VARCHAR(50) NOT NULL UNIQUE KEY,
CreatorID   TINYINT UNSIGNED NOT NULL ,
CreateDate  DATETIME DEFAULT NOW(),
FOREIGN KEY (CreatorID) REFERENCES `Account` ( AccountID)
);
-- add data group --
INSERT INTO `Group`(  GroupName		  		,  		CreatorID 	 		, 			CreateDate	 )
VALUES             (   'kiem tra'       		,        ' 1 '  			, 		    '2019/2/1' 	  ),
                   (  'quan li'        		,        ' 2 '				,			'2018/3/3'	 ),
                   (   'Marketing'  	  	,		 ' 3 ' 				,			'2017/4/2'	 ),
                   (	'sale' 				,		 ' 4 ' 				, 			'2016/4/6'	 );

-- bang 5 --
DROP TABLE IF EXISTS `GroupAccount`;
CREATE TABLE  `GroupAccount`(
GroupID 	TINYINT UNSIGNED NOT NULL,
AccountID 	TINYINT UNSIGNED NOT NULL ,
JoinDate   	DATETIME DEFAULT NOW() ,
PRIMARY KEY (GroupID,AccountID) ,
FOREIGN KEY( GroupID) REFERENCES `Group` (GroupID),
FOREIGN KEY(AccountID) REFERENCES `Account` (AccountID)
);
-- add data GroupAccount
INSERT INTO `GroupAccount` (GroupID ,   AccountID ,   JoinDate )
VALUES                      ( 1      ,   1         , '2019/9/3'),
							( 1      ,   2         , '2018/9/2'),
							( 2      ,   3         , '2014/8/1'),
							( 3      ,   4         , '2016/7/9');
 -- bang 6 --
 DROP TABLE IF EXISTS `TypeQuestion`;
CREATE TABLE `TypeQuestion`(
TypeID			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
TypeName 		ENUM ('Essay',' Multiple-Choice') NOT NULL UNIQUE KEY
);
-- add data TypeQuestion
INSERT INTO `TypeQuestion` (  TypeName )
VALUES 					   ('Essay'),
						   (' Multiple-Choice');
							
-- bang 7 --
DROP TABLE IF EXISTS `CategoryQuestion`;
CREATE TABLE `CategoryQuestion` (
CategoryID 			TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
CategoryName 		VARCHAR(50) NOT NULL UNIQUE KEY


);





-- add data CategoryQuestion
INSERT INTO `CategoryQuestion`		 (  CategoryName )
VALUES 							 	('Java'			),
									('ASP.NET'		),
									('ADO.NET'		),
									('SQL'			),
									('Postman'		),
									('Ruby'			);
								
                           
                           
-- bang 8 --
DROP TABLE IF EXISTS `Question`;
CREATE TABLE `Question`(
QuestionID 		TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
Content  		VARCHAR(100) NOT NULL UNIQUE KEY,
CategoryID  	TINYINT UNSIGNED NOT NULL ,
TypeID 			TINYINT UNSIGNED NOT NULL ,
CreatorID 		TINYINT UNSIGNED NOT NULL UNIQUE KEY,
CreateDate		DATETIME DEFAULT NOW(),
FOREIGN KEY (CategoryID) REFERENCES `CategoryQuestion`(CategoryID),
FOREIGN KEY (TypeID) REFERENCES `TypeQuestion`(TypeID),
FOREIGN KEY (CreatorID) REFERENCES `Account`(AccountID)


);

-- add data Question	
INSERT INTO `Question`      (Content ,           	      CategoryID ,   TypeID , CreatorID ,     CreateDate  )
	VALUES                 ( 'cac cau hoi ve java' 			 ,    1      ,    	1	,  1            , '2019/9/3'),
						   ( 'cac cau hoi ve asp.net'  		 ,   2    	 ,     2	,  2	        , '2018/9/2');
						   
-- bang 9 --
DROP TABLE IF EXISTS `Answer`;
CREATE TABLE `Answer`(
AnswerID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
Content  VARCHAR(100) NOT NULL,
QuestionID TINYINT UNSIGNED NOT NULL,
isCorrect ENUM('true','false') NOT NULL,
FOREIGN KEY (QuestionID) REFERENCES `Question`(QuestionID)
); 
-- add data Answer	
INSERT INTO `Answer`      (Content ,           	     QuestionID ,   isCorrect )
	VALUES                 ( 'cac loi giai java' 			 ,    1      ,    	1	),
						   ( 'cac loi giai asp.net'  		 ,   2    	 ,     2	);






-- bang 10 -- 
DROP TABLE IF EXISTS `Exam`;
CREATE TABLE Exam (
ExamID TINYINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
code   VARCHAR(500) NOT NULL,
Title  VARCHAR(30) NOT NULL,
CategoryID TINYINT UNSIGNED NOT NULL,
Duration  TIME ,
CreatorID TINYINT UNSIGNED NOT NULL,
CreateDate DATE ,
FOREIGN KEY (CreatorID) REFERENCES `Account` (AccountID),
FOREIGN KEY (CategoryID) REFERENCES `Question` ( CategoryID)
);
-- add data Exam	
INSERT INTO `Exam` (code 	, 			Title 	, 		 CategoryID		,		Duration	,	CreatorID	,	CreateDate   )
	VALUES         ( 'ms01'   ,	' de thi java' 	,		'1'				, 	'120'			,    2			,	'2019/8/2' )  ,
					( 'ms02'   ,	' de thi asp.net' 	,		'2'				, 	'120'			,    1		,	'2019/7/2' );  
-- bang 11 -- 
DROP TABLE IF EXISTS `ExamQuestion`;
CREATE TABLE `ExamQuestion`( 
ExamID TINYINT UNSIGNED  NOT NULL ,
QuestionID 	TINYINT UNSIGNED NOT NULL,
FOREIGN KEY(ExamID) REFERENCES Exam (ExamID) ,
PRIMARY KEY(ExamID,QuestionID)

);
-- add data ExamQuestion
INSERT INTO `ExamQuestion` (ExamID ,   QuestionID )
VALUES                      ( 1 	,	2),
							( 2 	,   1);






