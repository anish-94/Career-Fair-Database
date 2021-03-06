module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getEvents(res, mysql, context, complete){
      //mysql.pool.query("SELECT Event.id, name, location, date FROM Event", function(error, results, fields){
      mysql.pool.query("SELECT Event.id, Event.name, Event.location, Event.date, University.name AS university FROM Event JOIN University ON (hosted_at_university=University.id)", function(error, results, fields){
          if(error){
              res.write(JSON.stringify(error));
              res.end();
          }
          context.events = results;
          complete();
      });
    }

    function getPeople(res, mysql, context, complete, filter){
        //mysql.pool.query("SELECT bsg_people.id, fname, lname, bsg_planets.name AS homeworld, age FROM bsg_people INNER JOIN bsg_planets ON homeworld = bsg_planets.id", function(error, results, fields){
        var sql = "SELECT Student.id, first_name, last_name, GPA, graduation_date, major, University.name AS university FROM Student JOIN University on (attends_university=University.id)"
        if(filter != null){
          sql = "SELECT Student.id, first_name, last_name, GPA, graduation_date, major, University.name AS university FROM Student JOIN University on (attends_university=University.id) WHERE attends_university=\"" + filter + "\"";
        }
        mysql.pool.query(sql, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.people = results;
            //console.log(results);
            complete();
        });
    }

    function getUnivs(res, mysql, context, complete){
        mysql.pool.query("SELECT id, name FROM University", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.univs = results;
            complete();
        });
    }

    function getPerson(res, mysql, context, id, complete){
        //var sql = "SELECT id, fname, lname, homeworld, age FROM bsg_people WHERE id = ?";
        var sql = "SELECT id, first_name, last_name, GPA, graduation_date, major FROM Student WHERE id = ?"
        var inserts = [id];
        mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.Student = results[0];
            complete();
        });
    }

    /*Display all people. Requires web based javascript to delete users with AJAX*/

    router.get('/', function(req, res){
        var callbackCount = 0;
        var context = {};
        context.jsscripts = ["deleteperson.js"];
        var mysql = req.app.get('mysql');
        getPeople(res, mysql, context, complete, null);
        getUnivs(res, mysql, context, complete);
        getEvents(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('people', context);
            }
        }
    });

    /* Display one person for the specific purpose of updating people */

    router.get('/:id', function(req, res){
        callbackCount = 0;
        var context = {};
        context.jsscripts = ["updateperson.js"];
        var mysql = req.app.get('mysql');
        getPerson(res, mysql, context, req.params.id, complete);
        getUnivs(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 2) {
              res.render('update-person', context);
            }
        }
    });

    /* Adds a person, redirects to the people page after adding */

    router.post('/student', function(req, res){
        var mysql = req.app.get('mysql');
        var sql ="INSERT INTO Student (first_name, last_name, GPA, graduation_date, major, attends_university) VALUES (?,?,?,?,?,?)" ;
        var inserts = [req.body.first_name, req.body.last_name, req.body.GPA, req.body.graduation_date, req.body.major, req.body.university];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/people');
            }
        });
    });

    router.post('/', function(req, res){
      var callbackCount = 0;
      var context = {};
      context.jsscripts = ["deleteperson.js"];
      var mysql = req.app.get('mysql');
      var filter = req.body.university;
      if(filter == 0){
        filter = null;
      }
      getPeople(res, mysql, context, complete, filter);
      getUnivs(res, mysql, context, complete);
      getEvents(res, mysql, context, complete);
      function complete(){
          callbackCount++;
          if(callbackCount >= 3){
              res.render('people', context);
          }
      }
    });

    router.post('/event', function(req, res){
        var mysql = req.app.get('mysql');
        var sql ="INSERT INTO Event (name, location, date, hosted_at_university) VALUES (?,?,?,?)" ;
        var inserts = [req.body.name, req.body.location, req.body.date, req.body.university];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/people');
            }
        });
    });

    router.post('/university', function(req, res){
        var mysql = req.app.get('mysql');
        var sql ="INSERT INTO University (name, location) VALUES (?,?)" ;
        var inserts = [req.body.name, req.body.location];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/people');
            }
        });
    });

    router.post('/company', function(req, res){
        var mysql = req.app.get('mysql');
        var sql ="INSERT INTO Company (name, location, hiring_major) VALUES (?,?,?)" ;
        var inserts = [req.body.name, req.body.location, req.body.hiring_major];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.redirect('/people');
            }
        });
    });

    /* The URI that update data is sent to in order to update a person */

    router.put('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "UPDATE Student SET first_name=?, last_name=?, GPA=?, graduation_date=?, major=? WHERE Student.id=?";
        var inserts = [req.body.first_name, req.body.last_name, req.body.GPA, req.body.graduation_date, req.body.major, req.params.id];
        sql = mysql.pool.query(sql,inserts,function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }else{
                res.status(200);
                res.end();
            }
        });
    });

    /* Route to delete a person, simply returns a 202 upon success. Ajax will handle this. */

    router.delete('/:id', function(req, res){
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM Student WHERE id = ?";
        var inserts = [req.params.id];
        sql = mysql.pool.query(sql, inserts, function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.status(400);
                res.end();
            }else{
                res.status(202).end();
            }
        })
    })

    return router;
}();
