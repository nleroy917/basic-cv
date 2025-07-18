#import "utils.typ"

// name: Nathan J. LeRoy
// email: nleroy@virginia.edu
// phone: (+1) 513 300 5031
// url: https://nathanleroy.dev
// profiles:
//   - network: LinkedIn
//     username: nathanjleroy
//     url: https://linkedin.com/in/nathanjleroy
//   - network: GitHub
//     username: nleroy917
//     url: https://github.com/nleroy917
#let cv(
    name: "",
    email: "",
    phone: "",
    personal_site: "",
    linkedin: "",
    github: "",
    doc
) = {
    set page(
        paper: "us-letter", // a4, us-letter
        numbering: "1 / 1",
        number-align: center, // left, center, right
        margin: 0.5in,
    )

    set text(
        font: "Libertinus Serif",
        size: 10pt
    )

    set par(
        justify: true,
        spacing: 1em
    )
    
    show heading.where(
        level: 1,
    ): it => block(width: 100%)[
        #set text(size: 1.5em, weight: "bold")
        #upper(it.body)
        #v(2pt)
    ]

    show heading.where(
        level: 2,
    ): it => block(width: 100%)[
        #set align(left)
        #set text(size: 1em, weight: "bold")
        #upper(it.body)
        #v(-0.75em) #line(length: 100%, stroke: 1pt + black) // Draw a line
    ]

    align(center)[
        = #name
        #block(width: 100%)[
            #(
                link("mailto:" + email),
                phone,
                link("https://" + personal_site)[#personal_site],
                link("https://" + linkedin)[#linkedin],
                link("https://" + github)[#github]
            ).join("  ◆  ")
        ]
    ]

    doc
}

#let summary(summary) = {
    align(left)[
        summary
    ]
}

#let edu(
    start_date: none,
    end_date: none,
    url: none,
    institution: none,
    location: none,
    degree: none,
    area: none,
    current: false
) = {
    
    let start = utils.strpdate(start_date)
    let end = utils.strpdate(end_date)

    block(width: 100%)[
        // Line 1: Institution and Location
        *#link(url)[#institution]* #h(1fr) *#location* \
        // Line 2: Degree and Date Range
        #text(style: "italic")[#degree in #area] #h(1fr)
        #utils.monthname(start.month()) #start.year() #sym.dash.en 
        #if current [
            Present
        ] else [
            #utils.monthname(end.month()) #end.year()
        ]
            \
    ]
}

#let work(
    start_date: none,
    end_date: none,
    url: none,
    organization: none,
    location: none,
    position: none,
    current: false
) = {
    let start = utils.strpdate(start_date)
    let end = utils.strpdate(end_date)

    // Create a block layout for each education entry
    block(width: 100%)[
        // Line 1: Institution and Location
        #if url != none [
            *#link(url)[#organization]* #h(1fr) *#location* \
        ] else [
            *#organization* #h(1fr) *#location* \
        ]
        // Line 2: Degree and Date Range
        #text(style: "italic")[#position] #h(1fr)
        #utils.monthname(start.month()) #start.year() #sym.dash.en
        #if current [
                Present
        ] else [
                #utils.monthname(end.month()) #end.year()
        ]
    ]
}

#let projects(
    projectsdata: none
) = {
    for project in projectsdata {
        let start = utils.strpdate(project.startDate)
        block(width: 100%)[
            === #link(project.url)[#project.name] #h(1fr) #utils.monthname(start.month()) #start.year() #if project.active [(active)] \
            #text(style: "italic")[#project.role] #h(1fr)  \
            #project.summary
            #for tech in project.technologies [
                #text(fill: white)[
                    #highlight(fill: rgb("#A4A1A9"), extent: 2pt, radius: 3pt)[#tech]#sym.space.en
                ]
            ]
        ]
    }
}

#let awards(
    awardsdata: none,
) = {
    for award in awardsdata {
        // Parse ISO date strings into datetime objects
        let date = utils.strpdate(award.date)

        // Create a block layout for each education entry
        block(width: 100%)[
            // Line 1: Institution and Location
            *#award.title* #h(1fr) *#award.location - #utils.monthname(date.month()) #date.year()*\

        ]
    }
}

#let publication(
    title: "",
    authors: none,
    journal: "",
    year: "",
    month: "",
    doi: ""
) = {
    block(width: 100%)[
        *#link(doi)[#title]* \
        #authors.map(a => {
            if a.me [*#a.name*] else [#a.name]
        }).join(", ")\
        *#journal* (#year) DOI: #link(doi)[#doi]
    ]
}

#let skillgroup(
    group_name: none,
    skills: none
) = {
    [ 
        *#group_name*: #skills.join(", ")
        \
    ]
}
