# CV typst template
My basic CV template I use to render my CV -- nothing crazy!

Can be used like so. You, of course, need to have the data files in the `data/` directory, or change the paths accordingly.

```typst
#import "@local/cv:0.0.1": *

#show: cv.with(
    personalinfo: yaml("data/contact.yaml")
)

#education(educationdata: yaml("data/education.yaml"))
#work(
    workdata: yaml("data/work.yaml"),
    title: "Work Experience"
)
#awards(awardsdata: yaml("data/awards.yaml"))
#projects(projectsdata: yaml("data/projects.yaml"))
#skills(skillsdata: yaml("data/skills.yaml"))
#publications(publicationsdata: yaml("data/publications.yaml"))
```