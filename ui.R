library(shinythemes)

shinyUI(
  navbarPage(title = "Airbnb Visualization", 
             id ="nav",           
             theme = shinytheme("united"), #https://rstudio.github.io/shinythemes/
             
##### Overview ##########        
    tabPanel("Overview",
             br(),
             br(),
             br(),
             #img(src = "airbnb_overview.jpg", height = 600, weight =700, align="center")
             #use Shiny’s HTML tag functions to center the image
             #https://stackoverflow.com/questions/34663099/how-to-center-an-image-in-a-shiny-app
             HTML('<center><img src="airbnb_overview.jpg", height = 600, weight =700 ></center>')
             ),

##### Map ##########      
    tabPanel("NYC map",
      div(class="outer",
          tags$head(includeCSS("styles.css"),#customized CSS
                    includeScript("gomap.js")),
          
      leafletOutput(outputId = "map", width = "100%", height = "100%"),
                          
      # Panel options: borough, Room Type, Price, Rating, Reviews
      absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE, draggable = TRUE, 
                    top = 80, left = "auto", right = 20, bottom = "auto",
                    width = 320, height = "auto",
      h2("Airbnb in NYC"),
      checkboxGroupInput(inputId = "select_boro", label = h4("Borough"), 
                         choices = boro, selected = 'Manhattan'),
      checkboxGroupInput(inputId = "select_room", label = h4("Room Type"), 
                         choices = room, selected = room),
      sliderInput(inputId = "slider_price", label = h4("Price"), min = 1, max = 300, step = 20,
                  pre = "$", sep = ",", value = c(30, 300)),
      sliderInput(inputId = "slider_rating", label = h4("Rating Score"), min = 20, max = 100, step = 10,
                  value = c(60, 100)),
      sliderInput(inputId = "slider_review", label = h4("Number of Reviews"), min = 10, max = 450, step = 50,
                  value = c(10, 450)),
      h6("The map information is based on May 02, 2017 dataset from"),
      h6(a("Inside Airbnb", href = "http://insideairbnb.com/get-the-data.html", target="_blank"))
      ),
      
      # Results: count_room, avgprice
      absolutePanel(id = "controls", class = "panel panel-default", fixed = FALSE, draggable = TRUE, 
                    top = 320, left = 20, right = "auto" , bottom = "auto",
                    width = 320, height = "auto",
                    plotlyOutput(outputId = "count_room",height = 150),
                    plotlyOutput(outputId = "avgprice", height = 150))
      
      )),

##### Listings ##########               
    tabPanel("Listings, Boroughs and Price Changes",    
             fluidRow(
               column(3,
                      h3("Listings by Boroughs and Room Type"),
                      br(),
                      br(),
                      sliderInput(inputId = "tab2_price", h4("Price/Night"), min = 10, max = 500, value = c(10, 500)),
                      sliderInput(inputId = "tab2_rating", h4("Rating Score"), min = 10, max = 100, value = c(10,100)),
                      br(),
                      br(),
                      h3("Price Changes over Time"),
                      selectInput("price_option", label = h3("Select Time Type"), 
                                  choices = list("Year" = "Year","Month" = "Month"), selected = "Year")
               ),
               
               column(9,
                      h3(""),
                      plotlyOutput(outputId = "graph1", width=1000, height =350),
                      br(),
                      plotlyOutput(outputId = "tab_price", width=1000, height =350)
               )
                      
               )
             
             ),

##### References ##########      
    navbarMenu("References",
               tabPanel("Inside Airbnb",
                        h3("Inside Airbnb", a("Link", href="http://insideairbnb.com/get-the-data.html"))),

               tabPanel("Airbnb Business Model",
                        h3("Airbnb Business Model", a("Link", href="http://bmtoolbox.net/stories/airbnb/")))
               ) 
    #embed html https://stackoverflow.com/questions/17847764/put-a-html-link-to-the-r-shiny-application
    #embed pdf  https://gist.github.com/aagarw30/d5aa49864674aaf74951
    #embed web  https://stackoverflow.com/questions/33020558/embed-iframe-inside-shiny-app
))
