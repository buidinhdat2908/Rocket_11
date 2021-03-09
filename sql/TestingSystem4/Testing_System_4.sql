SELECT * FROM testingsystem.account;
-- cau 1 tạo store để người dùng nhập tên phòng ban và in ra tất cả các account thuộc phòng ban đó --
DELIMITER $$ 
CREATE PROCEDURE account_of_department(In in_DepartmentName VARCHAR(30)) -- In chỉ đến nơi cần tìm kiếm --
SELECT a.FullName
FROM `account` a
JOIN department b ON a.DepartmentID=b.DepartmentID
WHERE b.DepartmentName = in_DepartmentName;
end$$

DELIMITER ;

CALL account_of_department('sale');

--  Tạo store để in ra số lượng account trong mỗi group --
DELIMITER $$
CREATE PROCEDURE accout_of_groupaccount(In in_GroupID tinyint )
BEGIN 
SELECT GroupID a ,COUNT(a.GroupID)
FROM groupaccount a
WHERE a.GroupID = in_GroupID
GROUP BY a.GroupID;
end$$

DELIMITER ;
-- Tạo store để thống kê mỗi type question có bao nhiêu question được tạo trong tháng hiện tại --
DELIMITER $$
CREATE PROCEDURE typyquestion_of_mouth()
BEGIN
SELECT count(TypeID)
FROM question
WHERE MONTH(CreateDate) = Month(NOW());
end$$

DELIMITER ;
-- tạo store để trả ra id của type question có nhiều câu hỏi nhất --
DELIMITER $$ 
CREATE PROCEDURE max_type_question(out out_type_question tinyint )
BEGIN
SELECT q.TypeID Into out_type_question
FROM question q
JOIN typequestion tq on q.TypeID=tq.TypeID
GROUP BY q.TypeID
having count(q.QuestionID) = (SELECT max(x)
								FROM (SELECT count(q1.QuestionID) X
                                from question q1
                                GROUP BY q1.TypeID) y);
end$$
DELIMITER ;
set @Type_ID=0;
call max_type_question(@type_ID);
SELECT @type_ID;
-- Sử dụng store ở question 4 để tìm ra tên của type question --
DELIMITER $$
CREATE PROCEDURE sp_findNameByIDTypeQuestion()
BEGIN
	WITH MAX_Count_TypeID AS(
		SELECT		COUNT(TypeID)
		FROM		Question 
		GROUP BY	TypeID
        ORDER BY	COUNT(TypeID) DESC
		LIMIT 		1
    )
    SELECT 	TQ.TypeName
    FROM	Question Q INNER JOIN TypeQuestion TQ
    ON		Q.TypeID = TQ.TypeID
    GROUP BY Q.TypeID
    HAVING	COUNT(Q.TypeID) = (SELECT * FROM MAX_Count_TypeID);		
END$$
DELIMITER ;
--  Viết 1 store cho phép người dùng nhập vào 1 chuỗi và trả về group có tên chứa chuỗi của người dùng nhập vào hoặc trả về user có username chứa  chuỗi của người dùng nhập vào
DELIMITER $$
CREATE PROCEDURE sp_nameOfGroupOrUserName
(IN	in_stringInput VARCHAR(50), IN in_select TINYINT)
BEGIN
	IF in_select = 1 THEN
		SELECT 	*
        FROM	`Group`
        WHERE	GroupName LIKE in_stringInput;
	ELSE
		SELECT 	Email, Username, FullName
        FROM	`Account`
        WHERE	Username LIKE in_stringInput;
	END IF;
END$$
DELIMITER ;
-- cau 8 Viết 1 store cho phép người dùng nhập vào Essay hoặc Multiple-Choice để thống kê câu hỏi essay hoặc multiple-choice nào có content dài nhất
DELIMITER $$
CREATE PROCEDURE sp_maxContentWithTypeID
(IN in_TypeName VARCHAR(15))
BEGIN
	IF (in_TypeName = 'Essay') THEN
		SELECT	Content, MAX(LENGTH(Content))
		FROM	Question
		WHERE	TypeID = 1;
	ELSEIF (in_TypeName = 'Multiple-Choice') THEN
		SELECT	Content, MAX(LENGTH(Content))
		FROM	Question
		WHERE	TypeID = 2;
	END IF;
END$$
DELIMITER ;
-- cau 9 Viết 1 store cho phép người dùng xóa exam dựa vào ID
DELIMITER $$
CREATE PROCEDURE sp_DeleteExamWithID
(IN in_ExamID TINYINT UNSIGNED)
BEGIN
	DELETE 	
    FROM 	Exam 
    WHERE	ExamID = in_ExamID;	
    SELECT * FROM Exam;
END$$
DELIMITER ;
-- Question 10: Tìm ra các exam được tạo từ 3 năm trước và xóa các exam đó đi, sau đó in số lượng record đã remove từ các table liên quan trong khi removing
DROP PROCEDURE IF EXISTS sp_DeleteUser3Years;
DELIMITER $$
CREATE PROCEDURE sp_DeleteUser3Years()
BEGIN
	WITH ExamID3Year AS(
		SELECT 	ExamID
		FROM 	Exam
		WHERE	(YEAR(NOW()) - YEAR(CreateDate)) > 3
    )
	DELETE
    FROM Exam
    WHERE ExamID = (
		SELECT * FROM ExamID3Year
    );
END$$
DELIMITER ;
-- Question 11: Viết store cho phép người dùng xóa phòng ban bằng cách người dùng nhập vào tên phòng ban và các account thuộc phòng ban đó sẽ được chuyển về phòng ban default là phòng ban chờ việc

DROP PROCEDURE IF EXISTS sp_DeleteDepartment;
DELIMITER $$
CREATE PROCEDURE sp_DeleteDepartment
(IN	in_DepartmentName NVARCHAR(50))
BEGIN
	UPDATE 	`Account`
    SET		DepartmentID = 10
    WHERE	DepartmentID = (SELECT 	DepartmentID	
							FROM	Department
							WHERE 	DepartmentName = in_DepartmentName);
	DELETE 
    FROM	Department
    WHERE	DepartmentName = in_DepartmentName;
END$$
DELIMITER ;
