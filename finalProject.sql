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
  `id` int auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  primary key (`id`)
);

CREATE TABLE `Event`(
  `id` int auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  `date` date,
  primary key (`id`)
);

CREATE TABLE `Company`(
  `id` int auto_increment not null,
  `name` varchar(255) not null,
  `hiring_major` varchar(255),
  `location` varchar(255) not null,
  primary key (`id`)
);

CREATE TABLE `Enrolled`(
  `studentID` int,
  `universityID` int,
  primary key (`studentID`, `universityID`),
  foreign key(`studentID`) references Student(`id`),
  foreign key(`universityID`) references University(`id`)
);

CREATE TABLE `Hosts`(
  `eventID` int,
  `universityID` int,
  primary key (`eventID`, `universityID`),
  foreign key(`eventID`) references Event(`id`),
  foreign key(`universityID`) references University(`id`)
);

CREATE TABLE `Attends_Student`(
  `studentID` int,
  `eventID` int,
  primary key (`studentID`, `eventID`),
  foreign key(`studentID`) references Student(`id`),
  foreign key(`eventID`) references Event(`id`)
);

CREATE TABLE `Attends_Employee`(
  `companyID` int,
  `eventID` int,
  primary key (`companyID`, `eventID`),
  foreign key(`companyID`) references Company(`id`),
  foreign key(`eventID`) references Event(`id`)
);
