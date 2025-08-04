(function () {
  isoCountdownComplete = document.getElementsByName("countdown-complete")[0].content;
  const second = 1000,
        minute = second * 60,
        hour = minute * 60,
        day = hour * 24;

  var currentDate = new Date();
  var futureDate = new Date(isoCountdownComplete);
  var countDown = new Date(futureDate).getTime();
  var x = setInterval(function() {    
    let now = new Date().getTime(),
        distance = countDown - now;
  
      document.getElementById("countdown-days").innerText = Math.floor(distance / (day)),
      document.getElementById("countdown-hours").innerText = Math.floor((distance % (day)) / (hour)),
      document.getElementById("countdown-minutes").innerText = Math.floor((distance % (hour)) / (minute)),
      document.getElementById("countdown-seconds").innerText = Math.floor((distance % (minute)) / second);
  
      if (distance <= 0) {
        let headline = document.getElementById("headline"),
        countdown = document.getElementById("countdown"),
        content = document.getElementById("content");
        headline.innerText = "Currently awaiting next due date.";
        countdown.style.visibility = 'hidden';
        clearInterval(x);
      }
    }, 0)
  }());
