### Exercise 3 ###
library(jsonlite)

# Read in this police shooting JSON data 
# https://raw.githubusercontent.com/mkfreeman/police-shooting/master/data/response.json
data <- fromJSON('https://raw.githubusercontent.com/mkfreeman/police-shooting/master/data/response.json')


# Dealing with the `Shots Fired` column
# Creating a new Numeric variable with no space in the name
# Replacing NA values with the mean (that makes sense, right?)
data$shots_fired <- as.numeric(data[,'Shots Fired'])
data <- data %>%
        mutate(shots_fired = ifelse(is.na(shots_fired), mean(shots_fired, na.rm = T), shots_fired))

# Create a bubble map of the data

g <- list(
  scope = 'usa',
  projection = list(type = 'albers usa'),
  showland = TRUE,
  landcolor = toRGB(red),
  subunitwidth = 2,
  countrywidth = 1,
  subunitcolor = toRGB("grey"),
  countrycolor = toRGB("grey")
)

plot_ly(data, lon = lon, lat = lat, text = hover,
        marker = list(size = sqrt(pop/10000) + 1),
        color = q, type = 'scattergeo', locationmode = 'USA-states') %>%
  layout(title = 'Crowdsource Shooting<br>(By US City)', geo = g)


### Bonus: create informative hover text ###
hover <- paste(city, date, how_many_died)

### Bonus: Use multiple colors ###
