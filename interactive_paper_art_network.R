library(shiny)
library(dplyr)
library(geomnet)
library(igraph)
library(visNetwork)

color_pal=c("#fbb4ae",
            "#b3cde3")

ui <- fluidPage(
  #timevisOutput("timeline")
  visNetworkOutput("network")
)

server <- function(input, output, session) {
  output$network <- renderVisNetwork({
    nodes=read.table("interactive_network_nodes_12122020.csv",header=T,sep=";")#load("nodes.rdata")
    edges=read.table("interactive_network_edges_12122020.csv",header=T,sep=";")#load("edges.rdata")

    visNetwork(nodes, edges,height="200%") %>%visNodes()%>%
      visIgraphLayout()%>% visInteraction(navigationButtons = TRUE)%>% visEdges(
        shadow = T,
        color = list(color = "#0085AF", highlight = "#C62F4B")) %>%
      visEvents(selectNode = "function(properties) { window.open(this.body.data.nodes._data[properties.nodes[0]].adress); }")
  })
}

shinyApp(ui = ui, server = server)
