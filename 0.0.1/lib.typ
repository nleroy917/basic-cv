#import "utils.typ"

#let contacttext(info) = block(width: 100%)[
    #let profiles = (
        box(link("mailto:" + info.email)),
        box(link("tel:" + info.phone)),
        box(link(info.url)[#info.url.split("//").at(1)]),
    )

    #if none in profiles {
        profiles.remove(profiles.position(it => it == none))
    }

    #if info.profiles.len() > 0 {
        for profile in info.profiles {
            profiles.push(
                box(link(profile.url)[#profile.url.split("//").at(1)])
            )
        }
    }

    #text(weight: "medium", size: 9pt)[
        #pad(x: 0em)[
            #profiles.join([#sym.space.en #sym.diamond.filled #sym.space.en])
        ]
    ]
    
]

#let cv(
    personalinfo: none,
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
        = #personalinfo.name
        #contacttext(personalinfo)
    ]

    doc
}

#let cvsummary(summary) = {
    if info.summary != none [
        == Summary
        #align(left)[
            summary
        ]
        
    ]
}

// Education
#let education(
    educationdata: none,
    title: none
) = {
    
    if title != none [
        == #title
    ] else [
        == Education
    ]
    
    for edu in educationdata {
        // Parse ISO date strings into datetime objects
        let start = utils.strpdate(edu.startDate)
        let end = utils.strpdate(edu.endDate)

        // Create a block layout for each education entry
        block(width: 100%)[
            // Line 1: Institution and Location
            *#link(edu.url)[#edu.institution]* #h(1fr) *#edu.location* \
            // Line 2: Degree and Date Range
            #text(style: "italic")[#edu.studyType in #edu.area] #h(1fr)
            #utils.monthname(start.month()) #start.year() #sym.dash.en 
            #if edu.current [
                Present
            ] else [
                #utils.monthname(end.month()) #end.year()
            ]
                \
        ]
    }
}

#let work(
    workdata: none,
    title: none
) = {
    if title != none [
        == #title
    ] else [
        == Experience
    ]

    for w in workdata {
        // Parse ISO date strings into datetime objects
        let start = utils.strpdate(w.startDate)
        let end = utils.strpdate(w.endDate)

        // Create a block layout for each education entry
        block(width: 100%)[
            // Line 1: Institution and Location
            #if "url" in w [
                *#link(w.url)[#w.organization]* #h(1fr) *#w.location* \
            ] else [
                *#w.organization* #h(1fr) *#w.location* \
            ]
            // Line 2: Degree and Date Range
            #text(style: "italic")[#w.position] #h(1fr)
            #utils.monthname(start.month()) #start.year() #sym.dash.en
            #if w.current [
                    Present
            ] else [
                    #utils.monthname(end.month()) #end.year()
            ]
            // Highlights or Description
            #for hi in w.highlights [
                - #eval("[" + hi + "]")
            ]
        ]
    }
}

#let projects(
    projectsdata: none,
    title: none
) = {

    if title != none [
        == #title
    ] else [
        == Projects
    ]

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
    title: none
) = {
    if title != none [
        == #title
    ] else [
        == Awards, Grants, and Fellowships
    ]

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

#let publications(
    publicationsdata: none,
    title: none
) = {
    
    if title != none [
        == #title
    ] else [
        == Selected publications
    ]

    for pub in publicationsdata {
        // Parse ISO date strings into datetime objects
        // let date = utils.strpdate(pub.releaseDate)
        let author_count = 0
        // Create a block layout for each education entry
        block(width: 100%)[
            // Line 1: Institution and Location
            *#link(pub.doi)[#pub.title]* \
            #for author in pub.authors [
                #if author == "Nathan J. LeRoy" [
                    *#author*#if author_count < pub.authors.len() - 1 [, ] else []
                ] else [
                    #author#if author_count < pub.authors.len() - 1 [, ] else []
                ]
                // increment author count
                #{ author_count += 1 }
            ] \
            *#pub.journal* (#pub.year) DOI: #link(pub.doi)[#pub.doi] \
            // Line 2: Degree and Date Range
            // Published on #text(style: "italic")[#pub.publisher]  #h(1fr) #utils.monthname(date.month()) #date.year() \
        ]
    }
}

#let skills(
    skillsdata: none,
    title: none
) = {

    if title != none [
        == #title
    ] else [
        == Technical expertise
    ]
    
    for group in skillsdata [
        - *#group.category*: #group.skills.join(", ")
    ]

}
