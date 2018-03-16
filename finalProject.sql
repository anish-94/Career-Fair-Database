CREATE TABLE `Student`(
  `id` int auto_increment not null,
  `first_name` varchar(255) not null,
  `last_name` varchar(255) not null,
  `GPA` float,
  `graduation_date` date,
  `major` varchar(255),
  primary key (`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `University`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  primary key (`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Event`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `location` varchar(255) not null,
  `date` date,
  primary key (`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Company`(
  `id` int(11) auto_increment not null,
  `name` varchar(255) not null,
  `hiring_major` varchar(255),
  `location` varchar(255) not null,
  primary key (`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Enrolled`(
  `studentID` int(11) not null,
  `universityID` int(11) not null,
  primary key (`studentID`, `universityID`),
  foreign key(`studentID`) references Student(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE,
  foreign key(`universityID`) references University(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Hosts`(
  `eventID` int,
  `universityID` int,
  primary key (`eventID`, `universityID`),
  foreign key(`eventID`) references Event(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE,
  foreign key(`universityID`) references University(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Attends_Student`(
  `studentID` int,
  `eventID` int,
  primary key (`studentID`, `eventID`),
  foreign key(`studentID`) references Student(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE,
  foreign key(`eventID`) references Event(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE `Attends_Employee`(
  `companyID` int,
  `eventID` int,
  primary key (`companyID`, `eventID`),
  foreign key(`companyID`) references Company(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE,
  foreign key(`eventID`) references Event(`id`)
  ON DELETE SET NULL ON UPDATE CASCADE
);
