
SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `Student`;
DROP TABLE IF EXISTS `University`;
DROP TABLE IF EXISTS `Event`;
DROP TABLE IF EXISTS `Company`;
DROP TABLE IF EXISTS `Enrolled`;
DROP TABLE IF EXISTS `Hosts`;
DROP TABLE IF EXISTS `Attends_Student`;
DROP TABLE IF EXISTS `Attends_Company`;

CREATE TABLE `Student`(
  `id` int auto_increment not null,
  `first_name` varchar(255) not null,
  `last_name` varchar(255) not null,
  `GPA` float,
  `graduation_date` date,
  `major` varchar(255),
  `attends_university` int(11) default null,
  key `attends_university` (`attends_university`),
  constraint `attends_student_fk` foreign key(`attends_university`) references University(`id`) ON DELETE CASCADE,
  primary key (`id`)
);

CREATE TABLE `University`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  unique key `name` (`name`),
  primary key (`id`)
)ENGINE=InnoDB;

CREATE TABLE `Event`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  `date` date,
  `hosted_at_university` int(11) default null,
  key `hosted_at_university` (`hosted_at_university`),
  constraint `attends_event_fk` foreign key(`hosted_at_university`) references University(`id`) ON DELETE CASCADE,
  primary key (`id`)
)ENGINE=InnoDB;

CREATE TABLE `Company`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `hiring_major` varchar(255),
  `location` varchar(255) not null,
  primary key (`id`)
)ENGINE=InnoDB;

CREATE TABLE `Attends_Student`(
  `id` int(11) not null auto_increment,
  `studentID` int,
  `eventID` int,
  primary key (`id`),
  constraint `attends_student_ibfk_1` foreign key(`studentID`) references Student(`id`) ON DELETE CASCADE,
  constraint `attends_student_ibfk_2` foreign key(`eventID`) references Event(`id`) ON DELETE CASCADE
)ENGINE=InnoDB;

CREATE TABLE `Attends_Company`(
  `id` int(11) not null auto_increment,
  `companyID` int,
  `eventID` int,
  primary key (`id`),
  constraint `attends_employee_ibfk_1` foreign key(`companyID`) references Company(`id`) ON DELETE CASCADE,
  constraint `attends_employee_ibfk_2` foreign key(`eventID`) references Event(`id`) ON DELETE CASCADE
)ENGINE=InnoDB;

INSERT INTO Student (`first_name`, `last_name`, `GPA`, `graduation_date`, `major`, `attends_university`) VALUES
					("Adam", "Lowd", 4.0,  "2019-03-06", "Computer Science",2),
					("Jaden", "Smith", 3.2, "2024-06-15", "Business",1),
					("Diane", "Nguyen", 3.3,"2018-06-15", "Computer Science",5),
					("Mister", "Peanutbutter", 3.5,"2019-03-15","Business",3),
          ("Paul", "Blart", 3.4,  "2019-03-06", "Computer Science",2),
          ("Joe", "Bobbert", 3.23, "2024-12-15", "Business",1),
          ("Hue", "Huey", 3.23,"2018-08-15", "Computer Science",5),
          ("Mister", "Bubblegum", 3.23,"2019-01-15","architecture",3),
          ("Joe", "Biden", 2.3,  "2019-02-06", "Computer Engineer",2),
          ("Will", "Smith", 1.3, "2024-06-19", "Business",1),
          ("Queen", "Elizabeth", 2.7,"2018-06-14", "architecture",5),
          ("Emperor", "Palpatine", 1.3,"2019-02-15","Business",3),
					("Jeff", "Sessions", 1.9, "2020-05-15", "Economics",4);

INSERT INTO University (`name`, `location`) VALUES
						("Oregon State University", "Corvallis, OR"),
						("University of Washington", "Seattle, WA"),
						("New York University", "New York, NY"),
						("University of Michigan", "Ann Harbor, MI"),
						("University of Idaho", "Boise, ID");

INSERT INTO Event (`name`, `location`, `date`, `hosted_at_university`) VALUES
				  ("Baby Got Hack", "Corvallis, OR", "2018-04-15",1),
				  ("Networking Night", "Seattle, WA", "2019-01-12",2),
				  ("Career Fair 2018", "New York, NY", "2018-09-10",3),
				  ("HackOverflow", "Ann Harbor, MI", "2019-02-28",4),
				  ("Resume Review", "Boise, ID", "2018-12-05",5);

INSERT INTO Company (`name`, `hiring_major`, `location`) VALUES
					("Deloitte", "Business", "New York, NY"),
					("Amazon", "Computer Science", "Seattle, WA"),
					("Spotify", "Computer Science", "New York, NY"),
          ("FakeCompany1", "Business", "New York, NY"),
          ("FakeCompany2", "Computer Science", "Seattle, WA"),
          ("FakeCompany3", "Computer Science", "New York, NY"),
					("FakeCompany4", "Business", "Seattle, WA");

INSERT INTO Attends_Student (`studentID`, `eventID`) VALUES
			(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1), (7, 2), (8, 3), (9, 4), (10, 5), (11, 1), (12, 2), (13, 2);

INSERT INTO Attends_Company (`companyID`, `eventID`) VALUES
			(1, 1), (2, 2), (3, 3), (4, 4), (5, 5), (6, 1), (7, 2);

SET FOREIGN_KEY_CHECKS=1;
