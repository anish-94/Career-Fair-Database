#people.js queries

SELECT Event.id, Event.name, Event.location, Event.date, University.name AS university FROM Event JOIN University ON (hosted_at_university=University.id;
SELECT Student.id, first_name, last_name, GPA, graduation_date, major, University.name AS university FROM Student JOIN University on (attends_university=University.id;
SELECT Student.id, first_name, last_name, GPA, graduation_date, major, University.name AS university FROM Student JOIN University on (attends_university=University.id) WHERE attends_university=\"" + filter + "\""; "
SELECT id, first_name, last_name, GPA, graduation_date, major FROM Student WHERE id = ?;

INSERT INTO Student (first_name, last_name, GPA, graduation_date, major, attends_university) VALUES ([first_name], [last_name], [GPA], [graduation_date], [major], [university]);
INSERT INTO Event (name, location, date, hosted_at_university) VALUES ([name], [location], [date], [university]);
INSERT INTO University (name, location) VALUES ([name], [location]);
INSERT INTO Company (name, location, hiring_major) VALUES ([name], [location], [hiring_major]);
UPDATE Student SET first_name=[first_name], last_name=[last_name], GPA=[GPA], graduation_date=[graduation_date], major=[major] WHERE Student.id=[id];
DELETE FROM Student WHERE id = [id];
#var inserts = [req.params.id];


#list_of_events.js
SELECT id AS eventID, name, location, date FROM Event;
SELECT id AS companyID, name, hiring_major FROM Company;
SELECT eventID, companyID, Event.name AS event, Company.name AS company, Company.location AS location, Company.hiring_major AS hiring_major FROM Event INNER JOIN Attends_Company ON (Event.id = Attends_Company.eventID) INNER JOIN Company ON (Attends_Company.companyID = Company.id) ORDER BY Event.name;
INSERT INTO Attends_Company (companyID, eventID) VALUES ([companyID],[eventID]);
DELETE FROM Attends_Company WHERE eventID = [eventID] AND companyID = [companyID];

#student_attend.js
SELECT id AS eventID, name, location, date FROM Event;
SELECT id AS studentID, first_name, last_name, major FROM Student;
SELECT eventID, studentID, Event.name AS event, Student.first_name AS fname, Student.last_name AS lname FROM Event INNER JOIN Attends_Student ON (Event.id = Attends_Student.eventID) INNER JOIN Student ON (Attends_Student.studentID = Student.id) ORDER BY Event.name;
INSERT INTO Attends_Student (studentID, eventID) VALUES ([studentID],[eventID]);
DELETE FROM Attends_Student WHERE eventID = [eventID] AND studentID = [studentID];

