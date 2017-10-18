$(window).load(function(){
    
    getSubjects()
    $("select#paper_paper_subject_id").change(function(){
        getSubjects()
    })

    function getSubjects(){
        var paperSubjectId = $("select#paper_paper_subject_id").val()
        $.ajax({
            type: "GET",
            url: "/subjects/api/paper_subject_get_subjects.json?paper_subject_id="+paperSubjectId,
            dataType: "json",
            contentType: 'application/json',
            data: {}
            })
            .complete(function(data){
                var rowData = data.responseJSON
                var subjectNames = ""
                for(var i=0; i < rowData.length; i++){
                    subjectNames += rowData[i].name
                    subjectNames += ","
                }
                $("#relative-subjects").text(subjectNames)
            })
      }

})