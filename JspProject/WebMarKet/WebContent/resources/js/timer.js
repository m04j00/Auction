const countDownTimer = function(id, date, type) {

	let _vDate = new Date(date);
	console.log(_vDate);
	// 전달 받은 일자
	let _second = 1000;
	let _minute = _second * 60;
	let _hour = _minute * 60;
	let _day = _hour * 24;
	let timer;
	function showRemaining() {
		let now = new Date();
		let distDt = _vDate - now; if (distDt < 0) {
			clearInterval(timer);
			document.getElementById(id).textContent = '마감';
			return;
		}
		if (type == 1) {
			let days = Math.floor(distDt / _day);
			let hours = Math.floor((distDt % _day) / _hour);
			let minutes = Math.floor((distDt % _hour) / _minute);
			let seconds = Math.floor((distDt % _minute) / _second);
			document.getElementById(id).textContent = '남은 시간  ';
			document.getElementById(id).textContent += days + '일 ';
			document.getElementById(id).textContent += hours + '시간 ';
			document.getElementById(id).textContent += minutes + '분 ';
			document.getElementById(id).textContent += seconds + '초';
		}
		else {
			document.getElementById(id).textContent = '마감까지  ';
			let days = Math.floor(distDt / _day);
			if (days > 0) document.getElementById(id).textContent += days + '일 ';
			else {

				let hours = Math.floor((distDt % _day) / _hour);
				let minutes = Math.floor((distDt % _hour) / _minute);
				let seconds = Math.floor((distDt % _minute) / _second);

				if (hours == 0 && minutes == 0) {
					document.getElementById(id).textContent += seconds + '초';
				}
				else if (hours == 0) document.getElementById(id).textContent += hours + '시간 ';

				else document.getElementById(id).textContent += minutes + '분 ';
			}
		}

	}
	timer = setInterval(showRemaining, 1000);
}
/*let dateObj = new Date();
dateObj.setDate(dateObj.getDate() + 1);
countDownTimer('sample01', dateObj);
// 내일까지
countDownTimer('sample02', '04/01/2024 00:00 AM');
// 2024년 4월 1일까지, 시간을 표시하려면 01:00 AM과 같은 형식을 사용한다.
countDownTimer('sample03', '04/01/2024');
// 2024년 4월 1일까지
countDownTimer('sample04', '04/01/2019');
			// 2024년 4월 1일까지 */
