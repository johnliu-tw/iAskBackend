$(function(){
    var optionList = ["A","B","C","D","E","F","G","H"]
    console.log("YA")
    $("#add-option").click(function(){
        var optionNum = $(".question_option").length;
        var optionNum = optionNum + 1;
        if(optionNum<=optionList.length){
            var content="";
            $("#option-board").text("");
            for(var i=0;i<optionNum;i++){
                content+="<div class='form-group string optional question_question"+ optionList[i] +"'>"
                content+="<label class='control-label string optional' for='question_question"+ optionList[i] +"'>選項"+ optionList[i] +"</label>"
                content+="<input class='form-control string optional question_option' type='text' name='question[question"+ optionList[i] +"]' id='question_question"+ optionList[i] +"'>"
                content+="</div>"
                content+="<div class='form-group string optional question_question"+ optionList[i] +"_attr'>"
                content+="<label class='control-label string optional' for='question_question"+ optionList[i] +"_attr'>附檔</label>"
                content+="<input class='file optional' type='file' name='question[question"+ optionList[i] +"_attr]' id='question_question"+ optionList[i] +"_attr'>"
                content+="</div>"
            }
            $("#option-board").html(content);
            updateAnswerOptions($("#question_question_type").val(),optionNum);
            $("#question_optionCount").val(optionNum)
        }
    })
    $("#delete-option").click(function(){
        var optionNum = $(".question_option").length;
        var optionNum = optionNum - 1;
        if(optionNum >= 0){
            var content="";
            $("#option-board").text("");
            for(var i=0;i<optionNum;i++){
                content+="<div class='form-group string optional question_question"+ optionList[i] +"'>"
                content+="<label class='control-label string optional' for='question_question"+ optionList[i] +"'>選項"+ optionList[i] +"</label>"
                content+="<input class='form-control string optional question_option' type='text' name='question[question"+ optionList[i] +"]' id='question_question"+ optionList[i] +"'>"
                content+="</div>"
                content+="<div class='form-group string optional question_question"+ optionList[i] +"_attr'>"
                content+="<label class='control-label string optional' for='question_question"+ optionList[i] +"_attr'>附檔</label>"
                content+="<input class='file optional' type='file'  name='question[question"+ optionList[i] +"_attr]' id='question_question"+ optionList[i] +"_attr'>"
                content+="</div>"
            }
            $("#option-board").html(content);
            updateAnswerOptions($("#question_question_type").val(),optionNum);
            $("#question_optionCount").val(optionNum)
        }
    })
    $("#question_question_type").change(function(){
        var optionNum = $(".question_option").length;
        updateAnswerOptions($("#question_question_type").val(),optionNum)
    });
    $("div#answer-board").click(function(){
        var answerNum = $(".question_answer_checkbox:checked").length;
        var answerStirng="";
        for(var i=0; i<answerNum;i++){
            answerStirng += $(".question_answer_checkbox:checked")[i].value
        }
        $("#question_answer").val(answerStirng);
    });

    function updateAnswerOptions(questionType,optionNum){
        $("#answer-board").text("");  
        var content="";
        switch(questionType){
            case "單選":
                content+="<div class='form-group radio_buttons optional question_answer'>"
                content+="<label class='control-label radio_buttons optional'>答案</label>" 
                for(var i=0;i<optionNum;i++){
                    content+="<span class='radio inline'><label for='question_answer_"+ optionList[i] +"'>"
                    content+="<input class='radio_buttons optional' type='radio' value='"+ optionList[i] +"' name='question[answer]' id='question_answer_"+ optionList[i] +"'>"+ optionList[i] +"</label></span>"
                }
                content+="</div>"
                break;
            case "複選": 
                content+="<div class='form-group string optional question_answer'>"
                content+="<label class='control-label string optional' for='question_answer'>答案</label>"
                content+="<input type='hidden' name='question[answer]' id='question_answer'></input>"
                for(var i=0;i<optionNum;i++){
                    content+="<input type='checkbox' value='"+ optionList[i] +"' class='boolean optional question_answer_checkbox'>"+ optionList[i] +""
                } 
                content+="</div>"
                break;
            case "非選": 
                break;
        }
        $("#answer-board").html(content);
    }
})
