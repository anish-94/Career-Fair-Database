var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_hullale',
  password        : '0481',
  database        : 'cs340_hullale'
});
module.exports.pool = pool;
