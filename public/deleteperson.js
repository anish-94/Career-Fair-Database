function deletePerson(id){
    $.ajax({
        url: '/people/' + id,
        type: 'DELETE',
        success: function(result){
            window.location.reload(true);
        }
    })
};

function deleteStudent(eventID, studentID){
	//console.log('made it here');
  $.ajax({
      url: '/student_attend/event/' + eventID + '/student/' + studentID,
      type: 'DELETE',
      success: function(result){
          if(result.responseText != undefined){
            alert(result.responseText)
          }
          else {
            window.location.reload(true)
          }
      }
  })
};

function deleteCompany(eventID, companyID){
	//console.log('made it here');
  $.ajax({
      url: '/list_of_events/event/' + eventID + '/company/' + companyID,
      type: 'DELETE',
      success: function(result){
          if(result.responseText != undefined){
            alert(result.responseText)
          }
          else {
            window.location.reload(true)
          }
      }
  })

};
