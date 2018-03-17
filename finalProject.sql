
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `Student`;
DROP TABLE IF EXISTS `University`;
DROP TABLE IF EXISTS `Event`;
DROP TABLE IF EXISTS `Company`;
DROP TABLE IF EXISTS `Enrolled`;
DROP TABLE IF EXISTS `Hosts`;
DROP TABLE IF EXISTS `Attends_Student`;
DROP TABLE IF EXISTS `Attends_Employee`;

CREATE TABLE `Student`(
  `id` int auto_increment not null,
  `first_name` varchar(255) not null,
  `last_name` varchar(255) not null,
  `GPA` float,
  `graduation_date` date,
  `major` varchar(255),
  primary key (`id`)
);

CREATE TABLE `University`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  primary key (`id`)
)ENGINE=InnoDB;

CREATE TABLE `Event`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  `date` date,
  primary key (`id`)
)ENGINE=InnoDB;

CREATE TABLE `Company`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `hiring_major` varchar(255),
  `location` varchar(255) not null,
  primary key (`id`)
)ENGINE=InnoDB;

CREATE TABLE `Enrolled`(
  `id` int(11) not null auto_increment,
  `studentID` int(11) not null,
  `universityID` int(11) not null,
  primary key (`id`),
  constraint `enrolled_ibfk_1` foreign key(`studentID`) references Student(`id`) ON DELETE CASCADE,
  constraint `enrolled_ibfk_2` foreign key(`universityID`) references University(`id`) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE `Hosts`(
  `id` int(11) not null auto_increment,
  `eventID` int,
  `universityID` int,
  primary key (`id`),
  constraint `hosts_ibfk_1` foreign key(`eventID`) references Event(`id`) ON DELETE CASCADE,
  constraint `hosts_ibfk_2` foreign key(`universityID`) references University(`id`) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE `Attends_Student`(
  `id` int(11) not null auto_increment,
  `studentID` int,
  `eventID` int,
  primary key (`id`),
  constraint `attends_student_ibfk_1` foreign key(`studentID`) references Student(`id`) ON DELETE CASCADE,
  constraint `attends_student_ibfk_2` foreign key(`eventID`) references Event(`id`) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE `Attends_Employee`(
  `id` int(11) not null auto_increment,
  `companyID` int,
  `eventID` int,
  primary key (`id`),
  constraint `attends_employee_ibfk_1` foreign key(`companyID`) references Company(`id`) ON DELETE CASCADE,
  constraint `attends_employee_ibfk_2` foreign key(`eventID`) references Event(`id`) ON DELETE CASCADE
)ENGINE=InnoDB;

INSERT INTO Student (`first_name`, `last_name`, `GPA`, `graduation_date`, `major`) VALUES
					("Adam", "Lowd", 3.23,  "2019-03-06", "Computer Science"),
					("Jaden", "Smith", 3.23, "2024-06-15", "Business"),
					("Diane", "Nguyen", 3.23,"2018-06-15", "Computer Science"),
					("Mister", "Peanutbutter", 3.23,"2019-03-15","Business"),
					("Todd", "Chavez", 3.23, "2020-06-15", "Business");

INSERT INTO University (`name`, `location`) VALUES
						("Oregon State University", "Corvallis, OR"),
						("University of Washington", "Seattle, WA"),
						("New York University", "New York, NY"),
						("University of Michigan", "Ann Harbor, MI"),
						("University of Idaho", "Boise, ID");

INSERT INTO Event (`name`, `location`, `date`) VALUES
				  ("Baby Got Hack", "Corvallis, OR", "2018-04-15"),
				  ("Networking Night", "Seattle, WA", "2019-01-12"),
				  ("Career Fair 2018", "New York, NY", "2018-09-10"),
				  ("HackOverflow", "Ann Harbor, MI", "2019-02-28"),
				  ("Resume Review", "Boise, ID", "2018-12-05");

INSERT INTO Company (`name`, `hiring_major`, `location`) VALUES
					("Deloitte", "Business", "New York, NY"),
					("Amazon", "Computer Science", "Seattle, WA"),
					("Spotify", "Computer Science", "New York, NY"),
					("Capital One", "Business", "Seattle, WA");

INSERT INTO Enrolled (`studentID`, `universityID`) VALUES
			(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO Hosts (`eventID`, `universityID`) VALUES
			(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);
#			((SELECT Event.id from Event INNER JOIN University ON Event.location=University.location),
#			  (SELECT University.id from University INNER JOIN Event ON Event.location=University.location));

INSERT INTO Attends_Student (`studentID`, `eventID`) VALUES
			(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO Attends_Employee (`companyID`, `eventID`) VALUES
			(1, 1), (2, 2), (3, 3), (4, 4), (3, 5);

SET FOREIGN_KEY_CHECKS=1;
