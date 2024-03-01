async function getVisitorCounts() {
    const data = await fetch("https://3qy5ef4ucqubdkxudhmn66db340elsql.lambda-url.us-east-1.on.aws/");
    const json = await data.json();
    document.getElementById("visitor-count").innerHTML = "Visitor Counts: " + json.visitorCount;
}

getVisitorCounts()