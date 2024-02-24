async function getVisitorCounts() {
    const data = await fetch("https://vzz3m6s4n4nskvqqitrk4knsa40notto.lambda-url.us-east-1.on.aws/");
    const json = await data.json();
    document.getElementById("visitor-count").innerHTML = "Visitor Counts: " + json.visitorCount;
}

getVisitorCounts()