/*  # Memo
    - 노드삭제 대신 초기화 사용
    - 보완 할 것 : 노드수 제한 (12개정도?), 엔터누르면 초기화되는거 해소
    - 그려진 화면을 복사 및 재사용 -> canvas를 파일이나 이미지로 저장 가능 : 추후 구현 예정
*/

/* 전역변수 */
// 버튼 클릭 횟수
var btnCount = 1;
var toggle = true;
//시작 좌표 순서쌍 (x,y)
var x = 180;
var y = 100;

//기본 출발노드 생성 - 처음 및 초기화 시
function drawDefaultNode(x, y) {
	var canvas = document.getElementById('canvas');
	if (canvas.getContext) {
		var ctx = canvas.getContext('2d');
		
		var radius = 15;
		
		//원(Outer) 반지름 :15 / 둘레 : 2pi
		ctx.beginPath();
		ctx.arc(x, y, radius, 0, Math.PI * 2);
		ctx.fillStyle = "#29088A";
		ctx.fill();
		
		//원(Inner)
		ctx.beginPath();
		ctx.arc(x, y, 10, 0, Math.PI * 2);
		
		//기본 노드 색상
		ctx.fillStyle = "#BDBDBD";
		ctx.fill();
		
		//텍스트 추가
		addText(x, y + 25, "출발");
		
		//toggle값에 따라 방향 반전 (drawCurve 호출시 toggle)
		if (toggle) {
			x += radius;
		} else {
			x -= radius;
		}
		
		return [x, y];
	}
}


//클릭시 직선1 노드1 생성 , 노드4개 생성 되면 커브로 연결
function drawNodeAndLine() {

  if (btnCount == 16) {
      // alert("여행지를 15개 이상 추가하실 수 없습니다.");
      Swal.fire({
		  title: '여행지를 15개 이상 추가하실 수 없습니다.',
		  width: 600,
		  padding: '3em',
		  color: '#716add',
		  background: '#fff url(/tm/resources/images/alert.png)',
		  backdrop: `
		    rgba(40,23,100,0.1)
		  `, closeOnClickOutside : false
      }); 
      return;
  }

  //노드 4개 생성한 후 커브
  if (btnCount % 4 == 0) {
      if (toggle) {
          [x, y] = drawCurve_R(x, y); // 우측 곡선 그린 후 좌표 이동
      } else {
          [x, y] = drawCurve_L(x, y); //좌측 곡선 그린 후 좌표 이동
      }
      toggle = !toggle; //커브할 때 마다 토글
      [x, y] = drawNode(x, y); //노드 그린 후 좌표 이동
      btnCount++;

  } else {
      [x, y] = drawLine(x, y); //직선 그린 후 좌표 이동
      [x, y] = drawNode(x, y); //노드 그린 후 좌표 이동
      btnCount++;
  }

}

//좌표(x,y)에서 lineLength 만큼 직선 연결 -> 이동한 좌표 반환
function drawLine(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var lineLength = 180; // 선 길이
        ctx.lineWidth = 4; //선 굵기
        ctx.strokeStyle = "#29088A";

        ctx.beginPath();
        ctx.moveTo(x, y);

        //toggle값에 따라 방향 반전 (drawCurve 호출시 toggle)
        if (toggle) {
            ctx.lineTo(x + lineLength, y);
            x += lineLength;
        } else {
            ctx.lineTo(x - lineLength, y);
            x -= lineLength;
        }

        ctx.closePath();
        ctx.stroke();
        return [x, y];

    }
}

//좌표(x,y)에 반지름 15짜리 원 만들고 좌표 이동 -> 이동한 좌표 반환
//여행지 텍스트 추가
function drawNode(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var radius = 15;

        //원(Outer) 반지름 :15 / 둘레 : 2pi
        ctx.beginPath();
        ctx.arc(x, y, radius, 0, Math.PI * 2);
        ctx.fillStyle = "#29088A";
        ctx.fill();

        //원(Inner)
        ctx.beginPath();
        ctx.arc(x, y, 10, 0, Math.PI * 2);

//        //여행지 타입 가져오기
//        var obj_length = document.getElementsByName("placeType").length;
//        for (var i = 0; i < obj_length; i++) {
//            if (document.getElementsByName("placeType")[i].checked === true) {
//                var placeType = document.getElementsByName("placeType")[i].value
//            }
//        }
//
//        //타입에 따라 노드 색상 변경
//        if (placeType === '1') {
//            ctx.fillStyle = "#58ACFA";
//        } else if (placeType === '2') {
//            ctx.fillStyle = "#F5A9E1";
//        } else if (placeType === '3') {
//            ctx.fillStyle = "#CEF6D8";
//        }
//        ctx.fill();

        ctx.fillStyle = "#58ACFA";
        ctx.fill();
        
        //텍스트 추가
        addText(x, y + 25, document.getElementById('name').value);

        //toggle값에 따라 방향 반전 (drawCurve 호출시 toggle)
        if (toggle) {
            x += radius;
        } else {
            x -= radius;
        }

        return [x, y];

    }
}

// ** 추후 에 drawCurve_R, drawCurve_L 합칠것
//노드 4개 생성시 : 좌표(x,y)에서 좌측 커브 + 노드 생성후 좌표 반환
function drawCurve_R(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var lineLength = 50;
        var curveRadius = 60;

        ctx.lineWidth = 4; //선 굵기
        ctx.strokeStyle = "#29088A"; //선 색깔

        //직선(상)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x + lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x += lineLength;

        //곡선 (반원)
        ctx.beginPath();
        ctx.arc(x, y + curveRadius, curveRadius, Math.PI * 3 / 2, Math.PI / 2, false);
        ctx.stroke();
        y += curveRadius * 2  //y값 이동

        //직선(하)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x - lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x -= lineLength;

        return [x, y];
    }
}

//노드 4개 생성시 : 좌표(x,y)에서 우측 커브(좌측과 반전) + 노드 생성후 좌표 반환
function drawCurve_L(x, y) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');

        var lineLength = 50;
        var curveRadius = 60;

        ctx.lineWidth = 4; //선 굵기
        ctx.strokeStyle = "#29088A"; //선 색깔

        //직선(상)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x - lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x -= lineLength;

        //곡선 (반원)
        ctx.beginPath();
        ctx.arc(x, y + curveRadius, curveRadius, Math.PI * 3 / 2, Math.PI / 2, true);
        ctx.stroke();
        y += curveRadius * 2  //y값 이동

        //직선(하)
        ctx.beginPath();
        ctx.moveTo(x, y);
        ctx.lineTo(x + lineLength, y);
        ctx.closePath();
        ctx.stroke();
        x += lineLength;

        return [x, y];
    }
}

//노드에 여행지 이름 텍스트로 추가
function addText(x, y, text) {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        ctx.font = '25px Sans-Serif';
        ctx.textAlign = 'center';
        ctx.textBaseline = 'hanging';
        ctx.fillStyle = "#4C4C4C";

        ctx.fillText(text, x, y, 150);
    }
}

//처음상태로 초기화
function clearNode() {
    var canvas = document.getElementById('canvas');
    if (canvas.getContext) {
        var ctx = canvas.getContext('2d');
        ctx.clearRect(0, 0, canvas.width, canvas.height);

        //전역변수 초기화
        btnCount = 1;
        toggle = true;
        x = 180;
        y = 100;

        //출발 노드 생성
        [x, y] = drawDefaultNode(x, y);
    }
}

////완료 누를 시 - 마지막 노드 추가
//function drawEndNode(x, y) {
//    var canvas = document.getElementById('canvas');
//    if (canvas.getContext) {
//        var ctx = canvas.getContext('2d');
//
//        var radius = 15;
//
//        //원(Outer) 반지름 :15 / 둘레 : 2pi
//        ctx.beginPath();
//        ctx.arc(x, y, radius, 0, Math.PI * 2);
//        ctx.fillStyle = "#29088A";
//        ctx.fill();
//
//        //원(Inner)
//        ctx.beginPath();
//        ctx.arc(x, y, 10, 0, Math.PI * 2);
//
//        //기본 노드 색상
//        ctx.fillStyle = "#BDBDBD";
//        ctx.fill();
//
//        //텍스트 추가
//        addText(x, y + 25, "종료");
//
//        //toggle값에 따라 방향 반전 (drawCurve 호출시 toggle)
//        if (toggle) {
//            x += radius;
//        } else {
//            x -= radius;
//        }
//
//        return [x, y];
//    }
//}

////제목 추가
//function addTitle() {
//    var text = document.getElementById('placeTitle').value;
//
//    var canvas = document.getElementById('canvas');
//    if (canvas.getContext) {
//
//        var ctx = canvas.getContext('2d');
//        ctx.fillStyle = 'green';
//
//        //드로잉 전 초기화
//        ctx.clearRect(0, 5, canvas.width, 60);
//
//        ctx.font = '35px Jua';
//        ctx.textAlign = 'center';
//        ctx.textBaseline = 'hanging';
//        ctx.fillStyle = "#0080FF";
//
//        ctx.fillText(text, 500, 30, 500);
//    }
//}

//canvas 파일 이미지변환후 서버 업로드
function uploadCanvasData() {
	var frm = document.frm;
	var title = frm.title.value;
	var s_date = frm.s_date.value;
	var e_date = frm.e_date.value;
	var content = frm.content.value;
	
	if (!title) {
		// alert("제목을 입력하세요");
		Swal.fire({
			  title: '제목을 입력하세요',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(/tm/resources/images/alert.png)',
			  backdrop: `
			    rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
	      });
		return false;
	} else if (!s_date) {
		// alert("출발일을 입력하세요");
		Swal.fire({
			  title: '출발일을 입력하세요',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(/tm/resources/images/alert.png)',
			  backdrop: `
			    rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
	      });
		return false;
	} else if (!e_date) {
		// alert("도착일을 입력하세요");
		Swal.fire({
			  title: '도착일을 입력하세요',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(/tm/resources/images/alert.png)',
			  backdrop: `
			    rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
	      });
		return false;
	} else if (!content) {
		// alert("내용을 입력하세요");
		Swal.fire({
			  title: '내용을 입력하세요',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(/tm/resources/images/alert.png)',
			  backdrop: `
			    rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
	      });
		return false;
	}	
	
	// 도착일이 출발일보다 늦으면 저장 안되도록
	var startDate = new Date(s_date);
	var endDate = new Date(e_date);
	if (startDate > endDate) {
		// alert("출발일과 도착일을 확인하세요");
		Swal.fire({
			  title: '출발일과 도착일을 확인하세요',
			  width: 600,
			  padding: '3em',
			  color: '#716add',
			  background: '#fff url(/tm/resources/images/alert.png)',
			  backdrop: `
			    rgba(40,23,100,0.1)
			  `, closeOnClickOutside : false
	      });
		return false;
	}

    //폼 데이터 생성
    var form = $('#frm')[0];
	var formData = new FormData(form);

    var canvas = document.getElementById("canvas");
    var imageBase64 = canvas.toDataURL('image/png');

    //base64 to blob
    var decodedImg = atob(imageBase64.split(',')[1]);  // base64 데이터 디코딩
    var array = [];
    for (var i = 0; i < decodedImg.length; i++) {
    	array.push(decodedImg.charCodeAt(i));
    }
    
    var file = new Blob([new Uint8Array(array)], {type: 'image/png'}); // Blob 생성
    var today = new Date();
    var fileName = 'courseImg_'+ today.toLocaleDateString() + '_' + today.getMilliseconds() + '.png';
    formData.append("file", file, fileName);

    $.ajax({
        type: 'POST',
        url: 'bdInsert.do',
        data: formData,
        processData: false,	// data 파라미터 강제 string 변환 방지
        contentType: false,	// application/x-www-form-urlencoded; 방지
        enctype: 'multipart/form-data',
        cache: false,
        success: function (data) {
            // alert("게시글이 등록 되었습니다.");
            Swal.fire({
  			  title: '게시글이 등록 되었습니다.',
  			  width: 600,
  			  padding: '3em',
  			  color: '#716add',
  			  background: '#fff url(/tm/resources/images/alert.png)',
  			  backdrop: `
  			    rgba(40,23,100,0.1)
  			  `, closeOnClickOutside : false
  	      });
            location.replace('bdList.do');
        },
        error: function (request, status, error) {
            alert("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
        }
    });
}