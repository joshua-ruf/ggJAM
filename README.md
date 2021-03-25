# ggJAM


A live in-browser ggplot editor, using Shiny and Ace code editor.

Inspired by Mason DeCamillis' [ggplotLive](https://github.com/mdec/ggplotLive), and the well-documented examples in the [shinyAce](https://github.com/trestletech/shinyAce) package.

### Setup

You will need R installed as well as the four packages listed below. Run the following from the command line to install the packages.

```
R -e "install.packages(c('shiny', 'shinyAce', 'magrittr', 'ggplot2'), repos = c(CRAN = 'https://cran.rstudio.com'))"
```

### Use

In the command line run:

```
R -e "shiny::runApp(launch.browser=T)"
```
