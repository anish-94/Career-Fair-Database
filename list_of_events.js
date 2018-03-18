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

    function getCompanies(res, mysql, context, complete){
        //mysql.pool.query("SELECT bsg_people.id, fname, lname, bsg_planets.name AS homeworld, age FROM bsg_people INNER JOIN bsg_planets ON homeworld = bsg_planets.id", function(error, results, fields){
        mysql.pool.query("SELECT id AS companyID, name, hiring_major FROM Company", function(error, results, fields){
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

    router.post('/', function(req, res){
        var mysql = req.app.get('mysql');
        var companyID = req.body.companyID;
        var eventID = req.body.eventID;
        for (let company of companyID){
          var sql ="INSERT INTO Attends_Company (companyID, eventID) VALUES (?,?)" ;
          var inserts = [company, eventID];
          sql = mysql.pool.query(sql,inserts,function(error, results, fields){
              if(error){
                 console.log("error");
              }
          });
        }
        res.redirect('/list_of_events');
    });

    router.delete('/event/:eventID/company/:companyID', function(req, res){
        console.log('here in delete router');
        console.log(req.params.eventID);
        console.log(req.params.companyID);
        var mysql = req.app.get('mysql');
        var sql = "DELETE FROM Attends_Employee WHERE eventID = ? AND companyID = ?";
        var inserts = [req.params.eventID, req.params.studentID];
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
