# CV typst template
My basic CV template I use to render my CV -- nothing crazy!

Example usage below:

```typst
#import "@local/cv:0.0.1": *

#show: cv.with(
    name: "Nathan J. LeRoy",
    email: "me@me.com",
    phone: "(+1) 513 555 5555",
    personal_site: "nathanleroy.dev",
    linkedin: "linkedin.com/in/nathanjleroy",
    github: "github.com/nleroy917"
)

== Summary
// write a summary ...

== Education
#edu(
    start_date: "2021-08-01",
    end_date: "2025-08-01",
    url: "https://virginia.edu/",
    institution: "University of Virginia",
    location: "Charlottesville, Virginia",
    degree: "Doctor of Philosophy",
    area: "Biomedical Engineering",
    current: true
)
// other education ...

== Experience
#work(
    organization: "UVA - Sheffield lab",
    position: "PhD student / Graduate research assistant",
    url: "https://databio.org",
    location: "Charlottesville, Virginia",
    start_date: "2021-08-01",
    end_date: "2025-0`8-01",
    current: true
)
- highlight 1
- highlight 2
```
