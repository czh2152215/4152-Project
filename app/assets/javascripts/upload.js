document.addEventListener('DOMContentLoaded', function() {
    document.querySelector('.form-group').addEventListener('submit', function(e) {
        e.preventDefault();

        var file = document.querySelector('input[type=file]').files[0];
        var reader = new FileReader();

        reader.onloadend = function() {
            var base64 = reader.result;
            sendToApi(base64);
        }

        if (file) {
            reader.readAsDataURL(file);
        }
    });
});

function sendToApi(base64) {
    var xhr = new XMLHttpRequest();
    xhr.open("POST", "https://pm9i46r4p5.execute-api.us-east-1.amazonaws.com/default/ArtRecognition", true);
    xhr.setRequestHeader("Content-Type", "application/json");

    xhr.onreadystatechange = function() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            // 处理响应
            console.log(xhr.responseText);
        }
    }

    var data = JSON.stringify({
        "image": base64
    });

    xhr.send(data);
}
