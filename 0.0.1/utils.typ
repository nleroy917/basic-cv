#let months = (
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
)

// Helper Functions
#let monthname(n, display: "short") = {

    n = int(n) - 1 // Convert to 0-indexed
    let month = months.at(n)
    
    month
}

#let strpdate(isodate) = {
    let date = ""
    date = datetime(
        year: int(isodate.slice(0, 4)),
        month: int(isodate.slice(5, 7)),
        day: int(isodate.slice(8, 10))
    )
    date
}