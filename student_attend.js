module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getEvents(res, mysql, context, complete){
      //mysql.pool.query("SELECT Event.id, name, location, date FROM Event", function(error, results, fields){
      mysql.pool.query("SELECT id AS eventID, name, location, date FROM Event", function(error, results, fields){
          if(error){
              res.write(JSON.stringify(error));
              res.end();
          }
          context.events = results;
          complete();
      });
    }

    function getStudents(res, mysql, context, complete){
        //mysql.pool.query("SELECT bsg_people.id, fname, lname, bsg_planets.name AS homeworld, age FROM bsg_people INNER JOIN bsg_planets ON homeworld = bsg_planets.id", function(error, results, fields){
        mysql.pool.query("SELECT id AS studentID, first_name, last_name, major FROM Student", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.students = results;
            //console.log(results);
            complete();
        });
    }

    function getStudentsAtEvents(res, mysql, context, complete){
    sql = "SELECT eventID, studentID, Event.name AS event, Student.first_name AS fname, Student.last_name AS lname FROM Event INNER JOIN Attends_Student ON (Event.id = Attends_Student.eventID) INNER JOIN Student ON (Attends_Student.studentID = Student.id)"
     mysql.pool.query(sql, function(error, results, fields){
        if(error){
            res.write(JSON.stringify(error));
            res.end()
        }
        context.students_at_events = results
        complete();
    });
}

    /*Display all people. Requires web based javascript to delete users with AJAX*/

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteperson.js"];
        var mysql = req.app.get('mysql');
        getEvents(res, mysql, context, complete);
        getStudents(res, mysql, context, complete);
        getStudentsAtEvents(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('student_attend', context);
            }
        }
    });


    /* Adds a person, redirects to the people page after adding */

    router.post('/', function(req, res){
        var mysql = req.app.get('mysql');
        var studentID = req.body.studentID;
        var eventID = req.body.eventID;
        for (let student of studentID){
          var sql ="INSERT INTO Attends_Student (studentID, eventID) VALUES (?,?)" ;
          var inserts = [student, eventID];
          sql = mysql.pool.query(sql,inserts,function(error, results, fields){
              if(error){
                 console.log("error");
              }
          });
        }
        res.redirect('/student_attend');
    });


    return router;
}();
