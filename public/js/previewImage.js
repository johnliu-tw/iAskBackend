$(function(){
    var imageElementList = [".imgTitle",".imgA",".imgB",".imgC",".imgD",".imgE",".imgF",".imgAns"]
    var attributeElementList = ["#question_title_attr","#question_questionA_attr","#question_questionB_attr",
                                "#question_questionC_attr","#question_questionD_attr","#question_questionE_attr",
                                "#question_questionF_attr","#question_analysis_att"]
    addPreviewEvent(imageElementList,attributeElementList);
});
function addPreviewEvent(imageElementList,attributeElementList){
    for(var i=0; i<imageElementList.length;i++){
        if(i==0){
            var preview0 = $(imageElementList[i]);
        }
        if(i==1){
            var preview1 = $(imageElementList[i]);
        }
        if(i==2){
            var preview2 = $(imageElementList[i]);
        }
        if(i==3){
            var preview3 = $(imageElementList[i]);
        }
        if(i==4){
            var preview4 = $(imageElementList[i]);
        }
        if(i==5){
            var preview5 = $(imageElementList[i]);
        }
        if(i==6){
            var preview6 = $(imageElementList[i]);
        }
        if(i==7){
            var preview7 = $(imageElementList[i]);
        }
        $(attributeElementList[i]).change(function(event){
            var input = $(event.currentTarget);
            console.log(input)
            var file = input[0].files[0];
            var reader = new FileReader();
            reader.onload = function(e){
                image_base64 = e.target.result;
                if(input.attr("id")== "question_title_attr"){
                    preview0.attr("src", image_base64);
                }
                if(input.attr("id")== "question_questionA_attr"){
                    preview1.attr("src", image_base64);
                }
                if(input.attr("id")== "question_questionB_attr"){
                    preview2.attr("src", image_base64);
                }
                if(input.attr("id")== "question_questionC_attr"){
                    preview3.attr("src", image_base64);
                }
                if(input.attr("id")== "question_questionD_attr"){
                    preview4.attr("src", image_base64);
                }
                if(input.attr("id")== "question_questionE_attr"){
                    preview5.attr("src", image_base64);
                }
                if(input.attr("id")== "question_questionF_attr"){
                    preview6.attr("src", image_base64);
                }
                if(input.attr("id")== "question_analysis_att"){
                    preview7.attr("src", image_base64);
                }
            };
            reader.readAsDataURL(file);
        })
    }
}