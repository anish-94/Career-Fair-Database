module.exports = function(){
    var express = require('express');
    var router = express.Router();

    function getEvents(res, mysql, context, complete){
      //mysql.pool.query("SELECT Event.id, name, location, date FROM Event", function(error, results, fields){
      mysql.pool.query("SELECT id, name, location, date FROM Event", function(error, results, fields){
          if(error){
              res.write(JSON.stringify(error));
              res.end();
          }
          context.events = results;
          complete();
      });
    }

    function getCompanies(res, mysql, context, complete){
        //mysql.pool.query("SELECT bsg_people.id, fname, lname, bsg_planets.name AS homeworld, age FROM bsg_people INNER JOIN bsg_planets ON homeworld = bsg_planets.id", function(error, results, fields){
        mysql.pool.query("SELECT id, name, hiring_major FROM Company", function(error, results, fields){
            if(error){
                res.write(JSON.stringify(error));
                res.end();
            }
            context.companies = results;
            //console.log(results);
            complete();
        });
    }

    function getCompaniesAtEvents(res, mysql, context, complete){
    sql = "SELECT eventID, companyID, Event.name AS event, Company.name AS company FROM Event INNER JOIN Attends_Company ON (Event.id = Attends_Company.eventID) INNER JOIN Company ON (Attends_Company.companyID = Company.id)"
     mysql.pool.query(sql, function(error, results, fields){
        if(error){
            res.write(JSON.stringify(error));
            res.end()
        }
        context.companies_at_events = results
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
        getCompanies(res, mysql, context, complete);
        getCompaniesAtEvents(res, mysql, context, complete);
        function complete(){
            callbackCount++;
            if(callbackCount >= 3){
                res.render('list_of_events', context);
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
                res.redirect('/list_of_events');
            }
        });
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
                res.redirect('/list_of_events');
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
                res.redirect('/list_of_events');
            }
        });
    });


    return router;
}();
