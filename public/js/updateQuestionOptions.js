$(function(){
    var optionList = ["A","B","C","D","E","F","G","H"]

    activeMutipleAnswer();

    $("#add-option").click(function(){
        var oldOptionNum = $(".question_option").length;
        var newOptionNum = oldOptionNum + 1;
        if(newOptionNum<=optionList.length){
            var content="";
                content+="<div class='form-group string optional question_question"+ optionList[newOptionNum-1] +"'>"
                content+="<label class='control-label string optional' for='question_question"+ optionList[newOptionNum-1] +"'>選項"+ optionList[newOptionNum-1] +"</label>"
                content+="<input class='form-control string optional question_option' type='text' name='question[question"+ optionList[newOptionNum-1] +"]' id='question_question"+ optionList[newOptionNum-1] +"'>"
                content+="</div>"
                content+="<div class='form-group string optional question_question"+ optionList[newOptionNum-1] +"_attr'>"
                content+="<label class='control-label string optional' for='question_question"+ optionList[newOptionNum-1] +"_attr'>附檔</label>"
                content+="<input class='file optional' type='file' name='question[question"+ optionList[newOptionNum-1] +"_attr]' id='question_question"+ optionList[newOptionNum-1] +"_attr'>"
                content+="</div>"
            $("#option-board").append(content);
            updateAnswerOptions($("#question_question_type").val(),oldOptionNum,newOptionNum);
            $("#question_optionCount").val(newOptionNum)
        }
    })
    $("#delete-option").click(function(){
        var oldOptionNum = $(".question_option").length;
        var newOptionNum = oldOptionNum -1;
        if(newOptionNum >= 0){
            $("#option-board div").last().remove();
            $("#option-board div").last().remove();
            updateAnswerOptions($("#question_question_type").val(),oldOptionNum,newOptionNum);
            $("#question_optionCount").val(newOptionNum)
        }
    })
    $("#question_question_type").change(function(){
        var optionNum = $(".question_option").length;
        changeAnswerOptionsType($("#question_question_type").val(),optionNum)
    });
    $("div#answer-board").click(function(){
        var answerNum = $(".question_answer_checkbox:checked").length;
        var answerStirng="";
        for(var i=0; i<answerNum;i++){
            answerStirng += $(".question_answer_checkbox:checked")[i].value
        }
        $("#question_answer").val(answerStirng);
    });

    function updateAnswerOptions(questionType,oldOptionNum,newOptionNum){ 
        var content="";
        if(newOptionNum > oldOptionNum){
            switch(questionType){
                case "單選":
                    content+="<span class='radio inline'><label for='question_answer_"+ optionList[newOptionNum-1] +"'>"
                    content+="<input class='radio_buttons optional' type='radio' value='"+ optionList[newOptionNum-1] +"' name='question[answer]' id='question_answer_"+ optionList[newOptionNum-1] +"'>"+ optionList[newOptionNum-1] +"</label></span>"
                    break;
                case "複選": 
                    content+="<span class='checkbox inline'><label for='question_answer_e'>"
                    content+="<input type='checkbox' value='"+ optionList[newOptionNum-1] +"' class='boolean optional question_answer_checkbox'>"+ optionList[newOptionNum-1] +""
                    content+="</label></span>"
                    break;
                case "非選": 
                    break;       
                }
                $("div.question_answer").append(content);
        }
        else{
            $("div.question_answer span").last().remove();
        }
    }
    function changeAnswerOptionsType(questionType,optionNum){
        var radioAns = $(".question_answer_radio:checked").val()
        var checkboxAns = [];
        
        for(var i=0;i< $(".question_answer_checkbox:checked").length;i++){
            checkboxAns.push($(".question_answer_checkbox:checked")[0].value)
        }
        var content = "";
        $("#answer-board").text("")
        switch(questionType){
            case "單選":
                $("div#option-board").show();
                $("div#option-buttons").show();
                content+="<div class='form-group radio_buttons optional question_answer'>"
                content+="<label class='control-label radio_buttons optional'>答案</label>" 
                for(var i=0;i<optionNum;i++){
                    content+="<span class='radio inline'><label for='question_answer_"+ optionList[i] +"'>"
                    if( radioAns!=null && radioAns == optionList[i]){
                        content+="<input class='radio_buttons optional question_answer_radio' type='radio' value='"+ optionList[i] +"' name='question[answer]' id='question_answer_"+ optionList[i] +"' checked>"+ optionList[i] +"</label></span>"
                    }
                    else if(checkboxAns!=null && $.inArray(optionList[i],checkboxAns)>-1){
                        content+="<input class='radio_buttons optional question_answer_radio' type='radio' value='"+ optionList[i] +"' name='question[answer]' id='question_answer_"+ optionList[i] +"' checked>"+ optionList[i] +"</label></span>"
                    }
                    else{
                        content+="<input class='radio_buttons optional question_answer_radio' type='radio' value='"+ optionList[i] +"' name='question[answer]' id='question_answer_"+ optionList[i] +"'>"+ optionList[i] +"</label></span>"    
                    }
                }
                content+="</div>"
                break;
            case "複選": 
            $("div#option-board").show()
            $("div#option-buttons").show();
                content+="<div class='form-group string optional question_answer'>"
                content+="<label class='control-label string optional' for='question_answer'>答案</label>"
                content+="<input type='hidden' name='question[answer]' id='question_answer'></input>"
                for(var i=0;i<optionNum;i++){
                    if( radioAns!=null && radioAns == optionList[i]){
                        content+="<input type='checkbox' value='"+ optionList[i] +"' class='boolean optional question_answer_checkbox' checked>"+ optionList[i] +""
                    }
                    else if(checkboxAns!=null && $.inArray(optionList[i],checkboxAns)>-1){
                        content+="<input type='checkbox' value='"+ optionList[i] +"' class='boolean optional question_answer_checkbox' checked>"+ optionList[i] +""
                    }
                    else{
                        content+="<input type='checkbox' value='"+ optionList[i] +"' class='boolean optional question_answer_checkbox'>"+ optionList[i] +""
                    }
                } 
                content+="</div>"
                break;
            case "非選": 
            $("div#option-board").hide()
            $("div#option-buttons").hide();
                break;
        }
        $("#answer-board").html(content)        
    }
    function activeMutipleAnswer(){
        $("#question_answer").val()
        if($("#question_answer").val()){
            var answers=$("#question_answer").val().split("")
        }
        if($("#question_question_type").val()=="複選"){
            var checkboxs = $(".question_answer_checkbox")
            for(var i=0;i<checkboxs.length;i++){
                for(var j=0;j<answers.length;j++){
                    if(answers[j]==checkboxs[i].value){
                        checkboxs[i].setAttribute("checked","checked")
                    }
                }
            }
        }
    }
})
