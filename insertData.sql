INSERT INTO Student (`first_name`, `last_name`, `GPA`, `graduation_date`, `major`) VALUES
					("Adam", "Lowd", 3.23,  "2019-03-06", "Computer Science"),
					("Jaden", "Smith", 3.23, "2024-06-15", "Business"),
					("Diane", "Nguyen", 3.23,"2018-06-15", "Computer Science"),
					("Mister", "Peanutbutter", 3.23,"2019-03-15","Business"),
					("Todd", "Chavez", 3.23, "2020-06-15", "Business");

INSERT INTO University (`name`, `location`) VALUES
						("Oregon State University", "Corvallis OR"),
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
			( (1, 1), (2, 2), (3, 3), (4, 4), (5, 5) );

INSERT INTO Hosts (`eventID`, `universityID`) VALUES
			( (SELECT Event.id from Event INNER JOIN University ON Event.location=University.location),
			  (SELECT University.id from University INNER JOIN Event ON Event.location=University.location ) );

INSERT INTO Attends_Student (`studentID`, `eventID`) VALUES
			( (1, 1), (2, 2), (3, 3), (4, 4), (5, 5) );

INSERT INTO Attends_Employee (`companyID`, `eventID`) VALUES
			( (1, 1), (2, 2), (3, 3), (4, 4), (3, 5) );
