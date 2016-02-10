# Figure out what each line of code actually does!

library(plotly)

# I suggest you fiddle with the mapping options,
# Then come back and look at this data wrangling, if you have the time

df <- read.csv('https://raw.githubusercontent.com/plotly/datasets/master/2014_us_cities.csv')
df$hover <- paste(df$name, "Population", df$pop/1e6, " million") # what does this do? data to hover over
df$q <- with(df, cut(pop, quantile(pop))) # what does this do???? color?
levels(df$q) <- paste(c("1st", "2nd", "3rd", "4th", "5th"), "Quantile") # what does this do?what quartile they are ub
df$q <- as.ordered(df$q) # what does this do? keeps them ordered the way it is

library(plotly)
d <- diamonds[sample(nrow(diamonds), 1000), ]
# note how size is automatically scaled and added as hover text
plot_ly(d, x = carat, y = price, size = carat, mode = "markers")



g <- list(
  scope = 'usa', # what does this do? finds the country
  projection = list(type = 'albers usa'), # what does this do? type of projection
  showland = TRUE, # what does this do? whether to show the land
  landcolor = toRGB("gray85"), # what does this do? color
  subunitwidth = 1, # what does this do? increase
  countrywidth = 1, # what does this do? increase
  subunitcolor = toRGB("white"), # what does this do? color of subunit
  countrycolor = toRGB("white") # what does this do? color of country
)

plot_ly(df, 
        lon = lon,  
        lat = lat, 
        text = hover, # how does this work? when you hover over
        marker = list(size = sqrt(pop/10000) + 1), # what else can you adjust? size
        color = q, # what does this do? changes the color
        type = 'scattergeo', 
        locationmode = 'USA-states'
        ) %>%
  # what if you don't pass this into the layout function? caption/title 
layout(title = '2014 US city populations<br>(Click legend to toggle)', geo = g)
