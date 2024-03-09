async function getVisitorCounts() {
    try {
        const data = await fetch("https://3qy5ef4ucqubdkxudhmn66db340elsql.lambda-url.us-east-1.on.aws/");
        const json = await data.json();
        document.getElementById("visitor-count").innerHTML = "Visitor Counts: " + json.visitorCount;
    } catch (err) {
        document.getElementById("visitor-count").innerHTML = "Can't count, too many visitors!";
    }
    
}

getVisitorCounts()


const scrollers = document.querySelectorAll(".scroller");
if (!window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
    addAnimation();
}

function addAnimation() {
    scrollers.forEach(scroller => {
        scroller.setAttribute("data-animated", true);

        const scrollerInner = scroller.querySelector(".scroller-inner");
        const scrollerContent = Array.from(scrollerInner.children);

        scrollerContent.forEach((item) => {
            const duplicatedItem = item.cloneNode(true);
            duplicatedItem.setAttribute("aria-hidden", true);
            scrollerInner.appendChild(duplicatedItem);
        })
    });
}