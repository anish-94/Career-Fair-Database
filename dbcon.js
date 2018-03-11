var mysql = require('mysql');
var pool = mysql.createPool({
  connectionLimit : 10,
  host            : 'classmysql.engr.oregonstate.edu',
  user            : 'cs340_asrania',
  password        : '5652',
  database        : 'cs340_asrania'
});
module.exports.pool = pool;
