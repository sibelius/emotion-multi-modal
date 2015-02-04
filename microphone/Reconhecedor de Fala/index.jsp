<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
    <%@taglib uri="http://www.mentaframework.org/tags-mtw/" prefix="mtw" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<mtw:ajaxConfig/>
</head>
<script type="text/javascript">

    function sendSpeech() {
        if (document.getElementById("hid_emotion").value == "") return;
        var req = new mtw.request();
        req.onSuccess(cleanFields);
        req.addParameter("emotion", document.getElementById("hid_emotion").value);
        req.addParameter("quad", document.getElementById("hid_quad").value);
        req.setUrl("LoginAction.speech.mtw");
        req.send();
    }

    function cleanFields() {
        document.getElementById("hid_emotion").value = "";
        document.getElementById("hid_quad").value = "";
    }

</script>

<body>
    <input type="hidden" id="hid_emotion" value="" />
    <input type="hidden" id="hid_quad" value="" />


<textarea id="textarea" rows=10 cols=80></textarea>
<button id="button" onclick="toggleStartStop()">Start</button>
<script type="text/javascript">

var recognizing;
var recognition = new webkitSpeechRecognition();
recognition.continuous = true;
reset();
recognition.onend = reset();

recognition.lang = "pt-br";
recognition.onresult = function (event) {

        
        var emotions = [
			["raiva","irritado","irritada","irritante","irritadíssimo","irritadíssima","irritar","irritação","tenso","tensa","tensão","impaciente","impaciência","assustado","assustada","assustador","assustando","susto","medroso","medrosa","medo","amedrontado","amedrontada","estressado","estressada","estressante","estressar","estresse","indignado","indignada","indignação","indignar","furioso","furiosa","enfurecido","enfurecida","enfurecer","fúria","alarmado","alarmada","alarmante","belicoso","belicosa"], 
            ["raiva","entediado","entediada","entediante","entediando","entediar","tédio","frustrado","frustrada","frustrante","frustrar","frustrador","frustrando","angustiado","angustiada","angustiante","agustiador","angústia","angustiando","descontente","descontentamento","desconfiado","desconfiada","desconfiar","desconfiança","amargurado","amargurada","amargura","insultado","insultada","insultar","insulto"],
            ["triste","tristeza","desanimado","desanimada","desanimador","desanimando","desânimo","desanimar","insatisfeito","insatisfeita","insatisfação","decepcionado","decepcionada","decepcionante","decepcionando","decepcionar","desesperado","desesperada","desesperador","desesperando","desconfortável","desconfortante","desapontado","desapontada","desapontador","surpreso","surpresa","surpreendido","surpreendida","surpreendente","melancólico","melancólica","melancolia","miserável"],
	        ["triste","tristeza","desanimado","desanimada","desanimador","desanimando","desânimo","desanimar","entediado","entediada","entediante","entediando","entediar","tédio","desmotivado","desmotivada","desmotivador","desmotivante","preocupado","preocupada","preocupar","preocupante","ansioso","ansiosa","ansiedade","chateado","chateada","cansado","cansada","cansaço","cansativo","apreensivo","apreensiva","cabisbaixo","cabisbaixa"],
    	    ["neutro","neutra","tranquilo","tranquila","tranquilidade","educado","educada","pensativo","pensativa","empático","empática","empatia","contemplativo","contemplativa","sonolento","sonolenta","sono","pacífico","pacífica","paciente"],
        	["feliz","felicidade","tranquilo","tranquila","tranquilidade","satisfeito","satisfeita","satisfação","bem","calmo","calma","calmaria","contente","contentamento","confiante","confiança","relaxado","relaxada","impressionado","impressionada","impressionar","impressionante","impressionando","aliviado","aliviada","aliviar","aliviante","descontraido","descontraida","descontrair","amigável","gentil","gentileza"],
        	["feliz","felicidade","animado","animada","animador","animando","ânimo","animar","despreocupado","despreocupada","despreocupar","bravo","brava","alegre","alegria","entusiasmado","entusiasmada","entusiasmante","esperançoso","esperançosa","esperança","encantado","encantada","encantador","extasiado","extasiada","eufórico","eufórica","corajoso","corajosa","coragem","afoito","afoita","autoconfiante","autoconfiança","apaixonado","apaixonada","apaixonar","apaixonante"],
        	["surpreso","surpresa","surpreendido","surpreendida","surpreendente","empolgado","empolgada","empolgante","empolgando","empolgar","motivado","motivada","motivador","motivante","excitado","excitada","excitante","aventureiro","aventureira","aventura","superior","superiora","superioridade","convencido","convencida","compenetrado","compenetrada","persuasivo","persuasiva","persuasão","triunfante","triunfar","convencido","convencida","convencer","prepotente","vaidoso","vaidosa","vaidade","desejar","desejo"]
        ];
        
        for (var i = event.resultIndex; i < event.results.length; ++i) {
            if (event.results[i].isFinal) {
              var words = event.results[i][0].transcript.split(" ");
              for(var j = 0; words[j] != null; ++j) {
            
                for(var o = 0; o < 8; ++o) {
                    for(var w = 0; emotions[o][w] != null; ++w) {
                        if (emotions[o][w].localeCompare(words[j]) == 0) {
                            textarea.value += words[j];
                            textarea.value += " = ";
                            textarea.value += (o+1);
                            textarea.value += "\n";
                            document.getElementById("hid_emotion").value = words[j];
                            document.getElementById("hid_quad").value += (o+1) + ",";
                            break;
                        }
                    }
                }
              
              }
            }
          }
        if (document.getElementById("hid_emotion").value != "") sendSpeech();
}

function reset() {
  recognizing = false;
  button.innerHTML = "Click to Speak";
}

function toggleStartStop() {
  if (recognizing) {
    recognition.stop();
    reset();
  } else {
    recognition.start();
    recognizing = true;
    button.innerHTML = "Click to Stop";
  }
}

</script>

</body>
</html>

</body>
</html>
        